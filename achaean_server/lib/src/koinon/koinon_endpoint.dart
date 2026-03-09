import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Koinon query endpoints — discovery, agora, trust graph lookups.
class KoinonEndpoint extends Endpoint {
  /// Register a repo URL for indexing.
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
    return await PolitaiUser.db.findFirstRow(
      session,
      where: (t) => t.pubkey.equals(pubkey),
    );
  }

  /// List all known poleis.
  Future<List<PolisDefinition>> listPoleis(Session session) async {
    return await PolisDefinition.db.find(
      session,
      orderBy: (t) => t.discoveredAt,
      orderDescending: true,
    );
  }

  /// Get a polis by repo URL.
  Future<PolisDefinition?> getPolis(Session session, String repoUrl) async {
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
    return await ReadmeSignatureRecord.db.find(
      session,
      where: (t) => t.polisRepoUrl.equals(polisRepoUrl),
    );
  }

  /// Get trust declarations issued by a polites.
  Future<List<TrustDeclarationRecord>> getTrustDeclarations(
    Session session,
    String pubkey,
  ) async {
    return await TrustDeclarationRecord.db.find(
      session,
      where: (t) => t.fromPubkey.equals(pubkey),
    );
  }

  /// Get post references for a polis (the agora).
  ///
  /// Returns post references tagged for the given polis, ordered by timestamp.
  Future<List<PostReference>> getAgora(
    Session session,
    String polisRepoUrl, {
    int limit = 50,
    int offset = 0,
  }) async {
    return await PostReference.db.find(
      session,
      where: (t) => t.poleisTags.like('%$polisRepoUrl%'),
      orderBy: (t) => t.timestamp,
      orderDescending: true,
      limit: limit,
      offset: offset,
    );
  }
}
