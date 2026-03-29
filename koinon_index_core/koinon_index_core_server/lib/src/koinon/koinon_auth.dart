import 'package:serverpod/serverpod.dart';

import 'crypto_utils.dart';

/// Stateless keypair authentication for Koinon endpoints.
///
/// Token format: `pubkey:timestamp:signature`
/// - pubkey: 128-char hex ECDSA P-256 public key
/// - timestamp: ISO 8601 UTC timestamp
/// - signature: 128-char hex ECDSA signature of the timestamp bytes
///
/// Plugs into Serverpod's authenticationHandler. No registration,
/// no sessions, no database lookup. Fully stateless.
class KoinonAuthHandler {
  static const _maxAgeMinutes = 5;

  /// Serverpod authentication handler callback.
  ///
  /// [token] is extracted from the Authorization header by Serverpod.
  /// Returns [AuthenticationInfo] with the pubkey as user identifier,
  /// or null if verification fails.
  static Future<AuthenticationInfo?> handleAuthentication(
    Session session,
    String token,
  ) async {
    try {
      return await _verify(token);
    } catch (e) {
      session.log('KoinonAuth: verification failed: $e',
          level: LogLevel.warning);
      return null;
    }
  }

  /// Get the caller's pubkey from an authenticated session.
  ///
  /// Call this from endpoints that need the caller's identity.
  /// Throws if the session is not authenticated.
  static Future<String> verifyFromSession(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw Exception('Not authenticated');
    }
    return authInfo.authId;
  }

  static Future<AuthenticationInfo> _verify(String token) async {
    // Parse token: pubkey:timestamp:signature
    // Timestamp contains colons (ISO 8601), so we split carefully:
    // first segment = pubkey (128 chars), last segment = signature (128 chars),
    // middle = timestamp
    final parts = token.split(':');
    if (parts.length < 3) {
      throw Exception('Invalid token format');
    }
    final pubkey = parts.first;
    final signature = parts.last;
    final timestamp = parts.sublist(1, parts.length - 1).join(':');

    if (!CryptoUtils.isValidPublicKey(pubkey)) {
      throw Exception('Invalid public key format');
    }

    if (!CryptoUtils.isValidSignature(signature)) {
      throw Exception('Invalid signature format');
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

    // Verify signature of timestamp string
    final valid = await CryptoUtils.verifySignature(
      message: timestamp,
      signature: signature,
      publicKey: pubkey,
    );

    if (!valid) {
      throw Exception('Invalid signature');
    }

    return AuthenticationInfo(
      pubkey,
      {},
      authId: pubkey,
    );
  }
}
