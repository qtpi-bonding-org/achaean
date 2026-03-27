import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'age_graph.dart';
import 'koinon_auth.dart';

/// Koinon query endpoints — discovery, agora, trust graph lookups.
class KoinonEndpoint extends Endpoint {
  /// Register a repo URL for indexing (no auth — bootstrap endpoint).
  ///
  /// Used by clients to manually register their repo with the aggregator
  /// (bootstrap for first user on a forge without system webhooks).
  Future<void> register(Session session, String repoUrl) async {
    final existing = await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(repoUrl),
    );

    if (existing != null) return;

    await PolitaiUser.db.insertRow(
      session,
      PolitaiUser(
        pubkey: '', // Resolved during full indexing
        repoUrl: repoUrl,
        discoveredAt: DateTime.now(),
      ),
    );
  }

  /// Look up a polites by public key.
  Future<PolitaiUser?> getUser(Session session, String pubkey) async {
    await KoinonAuthHandler.verifyFromSession(session);
    return await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.pubkey.equals(pubkey),
    );
  }

  /// List all known poleis.
  Future<List<PolisDefinition>> listPoleis(Session session) async {
    await KoinonAuthHandler.verifyFromSession(session);
    return await PolisDefinition.db.find(
      session,
      orderBy: (t) => t.discoveredAt,
      orderDescending: true,
    );
  }

  /// Get a polis by repo URL.
  Future<PolisDefinition?> getPolis(Session session, String repoUrl) async {
    await KoinonAuthHandler.verifyFromSession(session);
    return await PolisDefinition.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(repoUrl),
    );
  }

  /// Get polis members: all signers with their trust connection count.
  ///
  /// Each PolisMember includes isSigner (always true since we start from signers)
  /// and trustConnections (number of mutual trust edges from other signers).
  /// Client compares trustConnections against polis.membershipThreshold.
  Future<List<PolisMember>> getPolisMembers(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);

    // Get all signers
    final signatures = await ReadmeSignatureRecord.db.find(
      session,
      where: (t) => t.polisRepoUrl.equals(polisRepoUrl),
    );

    if (signatures.isEmpty) return [];

    final signerPubkeys = signatures.map((s) => s.signerPubkey).toSet();

    // For each signer, count mutual trust connections from other signers
    final members = <PolisMember>[];
    for (final sig in signatures) {
      // Count: other signers who trust this signer AND this signer trusts them back
      // (mutual trust = both directions exist with level 'trust')
      final outgoing = await TrustDeclarationRecord.db.find(
        session,
        where: (t) =>
            t.fromPubkey.equals(sig.signerPubkey) &
            t.toPubkey.inSet(signerPubkeys) &
            t.level.equals('trust'),
      );
      final outgoingTargets = outgoing.map((t) => t.toPubkey).toSet();

      final incoming = await TrustDeclarationRecord.db.find(
        session,
        where: (t) =>
            t.toPubkey.equals(sig.signerPubkey) &
            t.fromPubkey.inSet(signerPubkeys) &
            t.level.equals('trust'),
      );

      // Mutual = both directions exist
      final mutualCount =
          incoming.where((t) => outgoingTargets.contains(t.fromPubkey)).length;

      // Look up repoUrl from PolitaiUser
      final user = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.pubkey.equals(sig.signerPubkey),
      );

      members.add(PolisMember(
        pubkey: sig.signerPubkey,
        repoUrl: user?.repoUrl ?? '',
        isSigner: true,
        trustConnections: mutualCount,
      ));
    }

    return members;
  }

  /// Get all trust and observe relationships for a polites, in both directions.
  Future<Relationships> getRelationships(
    Session session,
    String pubkey,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);

    final results = await Future.wait([
      TrustDeclarationRecord.db
          .find(session, where: (t) => t.fromPubkey.equals(pubkey)),
      TrustDeclarationRecord.db
          .find(session, where: (t) => t.toPubkey.equals(pubkey)),
      ObserveDeclarationRecord.db
          .find(session, where: (t) => t.fromPubkey.equals(pubkey)),
      ObserveDeclarationRecord.db
          .find(session, where: (t) => t.toPubkey.equals(pubkey)),
    ]);

    return Relationships(
      outgoingTrust: results[0] as List<TrustDeclarationRecord>,
      incomingTrust: results[1] as List<TrustDeclarationRecord>,
      outgoingObserve: results[2] as List<ObserveDeclarationRecord>,
      incomingObserve: results[3] as List<ObserveDeclarationRecord>,
    );
  }

  /// Get all flags for posts in a polis.
  Future<List<FlagRecord>> getFlagsForPolis(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);
    return await FlagRecord.db.find(
      session,
      where: (t) => t.polisRepoUrl.equals(polisRepoUrl),
    );
  }

  /// Get flags on posts by people the caller trusts.
  Future<List<FlagRecord>> getFlaggedPostsForVouchers(
    Session session,
  ) async {
    final callerPubkey = await KoinonAuthHandler.verifyFromSession(session);

    // Find who the caller trusts
    final trustDeclarations = await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(callerPubkey),
    );

    if (trustDeclarations.isEmpty) return [];

    final trustedPubkeys = trustDeclarations.map((t) => t.toPubkey).toSet();

    // Find flags on posts by people the caller trusts
    return await FlagRecord.db.find(
      session,
      where: (t) => t.postAuthorPubkey.inSet(trustedPubkeys),
    );
  }

  /// Get post references for a polis (the agora).
  ///
  /// Computes polis members via AGE, then returns posts from those members.
  Future<List<PostReference>> getAgora(
    Session session,
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  }) async {
    await KoinonAuthHandler.verifyFromSession(session);

    final polis = await PolisDefinition.db.findFirstRow(
      session,
      where: (t) => t.repoUrl.equals(polisRepoUrl),
    );
    final threshold = polis?.membershipThreshold ?? 1;

    final memberPubkeys = await AgeGraph.computeMembers(
      session,
      polisRepoUrl,
      threshold,
    );

    if (memberPubkeys.isEmpty) return [];

    return await PostReference.db.find(
      session,
      where: (t) =>
          t.authorPubkey.inSet(memberPubkeys.toSet()) &
          t.poleisTags.like('%$polisRepoUrl%'),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Get post references from trusted authors (personal feed).
  Future<List<PostReference>> getPersonalFeed(
    Session session, {
    int limit = 50,
    int offset = 0,
  }) async {
    final callerPubkey = await KoinonAuthHandler.verifyFromSession(session);

    final trustDeclarations = await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(callerPubkey),
    );

    final observeDeclarations = await ObserveDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(callerPubkey),
    );

    final feedPubkeys = trustDeclarations.map((t) => t.toPubkey).toSet()
      ..addAll(observeDeclarations.map((o) => o.toPubkey))
      ..add(callerPubkey); // Include own posts

    return await PostReference.db.find(
      session,
      where: (t) => t.authorPubkey.inSet(feedPubkeys),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Get all posts in a thread (root + direct replies).
  ///
  /// Returns the root post and all posts whose parentPostUrl matches
  /// the root. Single-level only — nested replies require the client
  /// to call getThread again with a reply's postUrl.
  Future<List<PostReference>> getThread(
    Session session,
    String rootPostUrl,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);

    final root = await PostReference.db.findFirstRow(
      session,
      where: (t) => t.postUrl.equals(rootPostUrl),
    );

    if (root == null) return [];

    final replies = await PostReference.db.find(
      session,
      where: (t) => t.parentPostUrl.equals(rootPostUrl),
      orderBy: (t) => t.timestamp,
    );

    return [root, ...replies];
  }
}
