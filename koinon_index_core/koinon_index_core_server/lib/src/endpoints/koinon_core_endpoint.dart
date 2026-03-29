import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../koinon/age_graph.dart';
import '../koinon/koinon_auth.dart';

/// Koinon core query endpoints — discovery, trust graph, and polis lookups.
class KoinonCoreEndpoint extends Endpoint {
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
  /// Uses a single AGE Cypher query for trust counting, then a batch ORM
  /// lookup for repo URLs. Client compares trustConnections against
  /// polis.membershipThreshold to determine full member vs provisional.
  Future<List<PolisMember>> getPolisMembers(
    Session session,
    String polisRepoUrl,
  ) async {
    await KoinonAuthHandler.verifyFromSession(session);

    // Single Cypher query: all signers + their mutual trust count
    final signers = await AgeGraph.getSignersWithTrustCounts(
      session,
      polisRepoUrl,
    );

    if (signers.isEmpty) return [];

    // Batch lookup repo URLs
    final users = await PolitaiUser.db.find(
      session,
      where: (t) => t.pubkey.inSet(signers.map((s) => s.pubkey).toSet()),
    );
    final repoUrlByPubkey = {
      for (final u in users) u.pubkey: u.repoUrl,
    };

    return signers
        .map((s) => PolisMember(
              pubkey: s.pubkey,
              repoUrl: repoUrlByPubkey[s.pubkey] ?? '',
              isSigner: true,
              trustConnections: s.trustConnections,
            ))
        .toList();
  }
}
