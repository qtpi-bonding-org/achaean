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

  /// Get all README signers for a polis.
  Future<List<ReadmeSignatureRecord>> getPolisSigners(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);
    return await ReadmeSignatureRecord.db.find(
      session,
      where: (t) => t.polisRepoUrl.equals(polisRepoUrl),
    );
  }

  /// Get computed members of a polis (signers who meet trust threshold).
  Future<List<PolitaiUser>> getPolisMembers(
    Session session,
    String polisRepoUrl,
  ) async {
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

    final members = <PolitaiUser>[];
    for (final pubkey in memberPubkeys) {
      final user = await PolitaiUser.db.findFirstRow(
        session,
        where: (t) => t.pubkey.equals(pubkey),
      );
      if (user != null) members.add(user);
    }
    return members;
  }

  /// Get trust declarations issued by a polites.
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(
    Session session,
    String pubkey,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);
    return await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(pubkey),
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

  /// Get posts for a polis (the agora).
  ///
  /// Computes polis members via AGE, then returns full post content
  /// from those members tagged for this polis.
  Future<List<CachedPost>> getAgora(
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

    return await CachedPost.db.find(
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

  /// Get personalized feed — posts from everyone the caller trusts,
  /// plus the caller's own posts.
  ///
  /// Spans all poleis. The caller's trust graph (from their koinon.json
  /// trust declarations) determines which authors appear.
  Future<List<CachedPost>> getPersonalFeed(
    Session session, {
    int limit = 50,
    int offset = 0,
  }) async {
    final callerPubkey = await KoinonAuthHandler.verifyFromSession(session);

    // Look up who the caller trusts
    final trustDeclarations = await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(callerPubkey),
    );

    final feedPubkeys = trustDeclarations.map((t) => t.toPubkey).toSet();
    feedPubkeys.add(callerPubkey); // Include caller's own posts

    return await CachedPost.db.find(
      session,
      where: (t) => t.authorPubkey.inSet(feedPubkeys),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }

  /// Get a thread — root post and all replies.
  ///
  /// Returns the post at the given path, plus all posts whose parent
  /// references point to it.
  Future<List<CachedPost>> getThread(
    Session session,
    String authorPubkey,
    String path,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);

    final results = <CachedPost>[];

    // Get root post
    final root = await CachedPost.db.findFirstRow(
      session,
      where: (t) =>
          t.authorPubkey.equals(authorPubkey) & t.path.equals(path),
    );
    if (root != null) results.add(root);

    // Get replies
    final replies = await CachedPost.db.find(
      session,
      where: (t) =>
          t.parentAuthorPubkey.equals(authorPubkey) &
          t.parentPath.equals(path),
      orderBy: (t) => t.timestamp,
    );
    results.addAll(replies);

    return results;
  }
}
