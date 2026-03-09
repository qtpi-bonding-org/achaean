import 'dart:convert';
import 'dart:typed_data';

import 'package:anonaccount_server/anonaccount_server.dart';
import 'package:serverpod/serverpod.dart';

/// Stateless keypair authentication for Koinon endpoints.
///
/// Client sends three headers:
/// - X-Koinon-Pubkey: hex-encoded ECDSA P-256 public key
/// - X-Koinon-Timestamp: ISO 8601 UTC timestamp
/// - X-Koinon-Signature: hex-encoded signature of the timestamp bytes
///
/// Verification:
/// 1. Check timestamp is within 5 minutes
/// 2. Verify ECDSA signature of timestamp bytes against provided pubkey
class KoinonAuth {
  static const _maxAgeMinutes = 5;

  /// Verify the request headers and return the caller's pubkey.
  ///
  /// Throws if verification fails.
  static Future<String> verify(Session session) async {
    final request = session.request;
    if (request == null) {
      throw Exception('No HTTP request available');
    }

    final pubkey = request.headers['X-Koinon-Pubkey']?.first;
    final timestamp = request.headers['X-Koinon-Timestamp']?.first;
    final signature = request.headers['X-Koinon-Signature']?.first;

    if (pubkey == null || timestamp == null || signature == null) {
      throw Exception('Missing auth headers');
    }

    // Check timestamp freshness
    final ts = DateTime.tryParse(timestamp);
    if (ts == null) {
      throw Exception('Invalid timestamp format');
    }

    final age = DateTime.now().toUtc().difference(ts);
    if (age.inSeconds.abs() > _maxAgeMinutes * 60) {
      throw Exception('Timestamp too old');
    }

    // Verify signature of timestamp bytes
    final timestampBytes = utf8.encode(timestamp);
    final valid = await CryptoAuth.verifySignature(
      pubkey,
      Uint8List.fromList(timestampBytes),
      signature,
    );

    if (!valid) {
      throw Exception('Invalid signature');
    }

    return pubkey;
  }
}
