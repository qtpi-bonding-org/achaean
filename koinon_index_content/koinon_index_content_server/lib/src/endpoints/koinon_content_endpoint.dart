import 'package:koinon_index_core_server/koinon_index_core_server.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Koinon content query endpoints — feeds, threads, and flag lookups.
class KoinonContentEndpoint extends Endpoint {
  /// Get post references for a polis (the agora).
  ///
  /// Computes polis members via AGE, then returns posts from those members
  /// that are tagged for the given polis.
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

  /// Get post references from trusted and observed authors (personal feed).
  ///
  /// Includes the caller's own posts.
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
}
