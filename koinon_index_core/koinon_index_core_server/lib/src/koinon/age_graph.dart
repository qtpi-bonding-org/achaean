import 'package:serverpod/serverpod.dart';

/// Apache AGE graph operations for the Koinon trust graph.
///
/// All methods use raw SQL via session.db.unsafeExecute/unsafeQuery.
/// AGE Cypher queries are wrapped in SELECT * FROM cypher('koinon', $$ ... $$).
class AgeGraph {
  /// Sanitize a string value for use in Cypher queries.
  static String _s(String value) => value.replaceAll("'", "''");


  /// Ensure the AGE extension and koinon graph exist.
  /// Call once on server startup.
  static Future<void> initialize(Session session) async {
    await session.db.unsafeExecute('CREATE EXTENSION IF NOT EXISTS age');
    await session.db.unsafeExecute(
      "LOAD 'age'",
    );
    await session.db.unsafeExecute(
      'SET search_path = ag_catalog, "\$user", public',
    );

    // Create graph if it doesn't exist
    final result = await session.db.unsafeQuery(
      "SELECT * FROM ag_catalog.ag_graph WHERE name = 'koinon'",
    );
    if (result.isEmpty) {
      await session.db.unsafeExecute(
        "SELECT * FROM ag_catalog.create_graph('koinon')",
      );
    }
  }

  /// Ensure AGE is loaded for this session (must be called before any Cypher query).
  static Future<void> _loadAge(Session session) async {
    await session.db.unsafeExecute("LOAD 'age'");
    await session.db.unsafeExecute(
      'SET search_path = ag_catalog, "\$user", public',
    );
  }

  /// Upsert a Polites node.
  static Future<void> upsertPolites(
    Session session,
    String pubkey,
  ) async {
    await _loadAge(session);
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MERGE (p:Polites {pubkey: '${_s(pubkey)}'})"
      "\$\$) AS (v agtype)",
    );
  }

  /// Upsert a Polis node.
  static Future<void> upsertPolis(
    Session session,
    String repoUrl,
    int membershipThreshold,
  ) async {
    await _loadAge(session);
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MERGE (p:Polis {repo_url: '${_s(repoUrl)}'})"
      " SET p.membership_threshold = $membershipThreshold"
      "\$\$) AS (v agtype)",
    );
  }

  /// Delete all TRUSTS edges from a polites and re-create from current state.
  static Future<void> replaceTrustEdges(
    Session session,
    String fromPubkey,
    List<({String toPubkey, String level})> edges,
  ) async {
    await _loadAge(session);

    // Delete existing trust edges from this polites
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (from:Polites {pubkey: '${_s(fromPubkey)}'})-[r:TRUSTS]->()"
      " DELETE r"
      "\$\$) AS (v agtype)",
    );

    // Create new edges
    for (final edge in edges) {
      await session.db.unsafeExecute(
        "SELECT * FROM cypher('koinon', \$\$"
        " MERGE (from:Polites {pubkey: '${_s(fromPubkey)}'})"
        " MERGE (to:Polites {pubkey: '${_s(edge.toPubkey)}'})"
        " MERGE (from)-[:TRUSTS {level: '${_s(edge.level)}'}]->(to)"
        "\$\$) AS (v agtype)",
      );
    }
  }

  /// Delete all SIGNED edges from a polites and re-create from current state.
  static Future<void> replaceSignedEdges(
    Session session,
    String signerPubkey,
    List<String> polisRepoUrls,
  ) async {
    await _loadAge(session);

    // Delete existing signed edges from this polites
    await session.db.unsafeExecute(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (s:Polites {pubkey: '${_s(signerPubkey)}'})-[r:SIGNED]->()"
      " DELETE r"
      "\$\$) AS (v agtype)",
    );

    // Create new edges
    for (final repoUrl in polisRepoUrls) {
      await session.db.unsafeExecute(
        "SELECT * FROM cypher('koinon', \$\$"
        " MERGE (s:Polites {pubkey: '${_s(signerPubkey)}'})"
        " MERGE (p:Polis {repo_url: '${_s(repoUrl)}'})"
        " MERGE (s)-[:SIGNED]->(p)"
        "\$\$) AS (v agtype)",
      );
    }
  }

  /// Get all signers for a polis with their mutual trust connection count.
  ///
  /// Returns (pubkey, trustConnections) for every signer, regardless of threshold.
  /// The caller decides membership by comparing against the threshold.
  static Future<List<({String pubkey, int trustConnections})>> getSignersWithTrustCounts(
    Session session,
    String polisRepoUrl,
  ) async {
    await _loadAge(session);

    final result = await session.db.unsafeQuery(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (signer:Polites)-[:SIGNED]->(p:Polis {repo_url: '${_s(polisRepoUrl)}'})"
      " WITH signer, p"
      " OPTIONAL MATCH (signer)-[:TRUSTS {level: 'trust'}]->(other:Polites)-[:TRUSTS {level: 'trust'}]->(signer)"
      " WHERE (other)-[:SIGNED]->(p)"
      " WITH signer, count(other) AS mutual_count"
      " RETURN signer.pubkey, mutual_count"
      "\$\$) AS (pubkey agtype, mutual_count agtype)",
    );

    return result.map((row) {
      final pubkey = (row[0] as String).replaceAll('"', '');
      final count = int.tryParse(row[1].toString()) ?? 0;
      return (pubkey: pubkey, trustConnections: count);
    }).toList();
  }

  /// Compute polis members: signers with >= threshold mutual TRUST edges.
  ///
  /// Returns list of pubkeys that are members.
  static Future<List<String>> computeMembers(
    Session session,
    String polisRepoUrl,
    int threshold,
  ) async {
    await _loadAge(session);

    if (threshold <= 0) {
      // Threshold 0: all signers are members
      final result = await session.db.unsafeQuery(
        "SELECT * FROM cypher('koinon', \$\$"
        "MATCH (s:Polites)-[:SIGNED]->(p:Polis {repo_url: '${_s(polisRepoUrl)}'})"
        " RETURN s.pubkey"
        "\$\$) AS (pubkey agtype)",
      );
      return result
          .map((row) => (row[0] as String).replaceAll('"', ''))
          .toList();
    }

    // Find signers who have >= threshold mutual trust edges with other signers
    final result = await session.db.unsafeQuery(
      "SELECT * FROM cypher('koinon', \$\$"
      "MATCH (signer:Polites)-[:SIGNED]->(p:Polis {repo_url: '${_s(polisRepoUrl)}'})"
      " WITH signer, p"
      " OPTIONAL MATCH (signer)-[:TRUSTS {level: 'trust'}]->(other:Polites)-[:TRUSTS {level: 'trust'}]->(signer)"
      " WHERE (other)-[:SIGNED]->(p)"
      " WITH signer, count(other) AS mutual_count"
      " WHERE mutual_count >= $threshold"
      " RETURN signer.pubkey"
      "\$\$) AS (pubkey agtype)",
    );

    return result
        .map((row) => (row[0] as String).replaceAll('"', ''))
        .toList();
  }
}
