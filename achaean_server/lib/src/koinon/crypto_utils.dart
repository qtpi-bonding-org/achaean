import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// ECDSA P-256 cryptographic utilities for Koinon auth.
///
/// Adapted from serverpod_anonaccred CryptoUtils.
class CryptoUtils {
  /// Validates ECDSA P-256 public key format.
  ///
  /// Accepts 128 hex chars (raw x||y) or 130 hex chars (04 prefix + x||y).
  static bool isValidPublicKey(String publicKey) {
    if (publicKey.length != 128 && publicKey.length != 130) return false;
    if (publicKey.length == 130 && !publicKey.startsWith('04')) return false;
    return _isHexString(publicKey);
  }

  /// Validates ECDSA P-256 signature format (128 hex chars = 64 bytes r||s).
  static bool isValidSignature(String signature) {
    return signature.length == 128 && _isHexString(signature);
  }

  /// Verify an ECDSA P-256 signature.
  ///
  /// [message] is the plaintext that was signed.
  /// [signature] is 128 hex chars (r||s, 32 bytes each).
  /// [publicKey] is 128 or 130 hex chars.
  static Future<bool> verifySignature({
    required String message,
    required String signature,
    required String publicKey,
  }) async {
    try {
      if (!isValidPublicKey(publicKey) || !isValidSignature(signature)) {
        return false;
      }

      // Encode message to bytes — ECDSASigner handles SHA-256 hashing
      // internally when initialized with SHA256Digest().
      // dart_jwk_duo's signBytes() also hashes internally via webcrypto,
      // so both sides do exactly one SHA-256 hash.
      final messageBytes = Uint8List.fromList(utf8.encode(message));

      // Parse public key — extract x||y coordinates
      final pubKeyHex = publicKey.length == 130
          ? publicKey.substring(2) // Strip 04 prefix
          : publicKey;
      final pubKeyBytes = hexToBytes(pubKeyHex);
      final x = pubKeyBytes.sublist(0, 32);
      final y = pubKeyBytes.sublist(32, 64);
      final xBigInt = _bytesToBigInt(x);
      final yBigInt = _bytesToBigInt(y);

      // Create EC point on P-256 curve
      final domainParams = ECDomainParameters('secp256r1');
      final point = domainParams.curve.createPoint(xBigInt, yBigInt);
      final ecPublicKey = ECPublicKey(point, domainParams);

      // Parse signature — extract r||s (32 bytes each)
      final sigBytes = hexToBytes(signature);
      final r = _bytesToBigInt(sigBytes.sublist(0, 32));
      final s = _bytesToBigInt(sigBytes.sublist(32, 64));
      final ecSignature = ECSignature(r, s);

      // Verify
      final signer = ECDSASigner(SHA256Digest());
      signer.init(
        false,
        PublicKeyParameter<ECPublicKey>(ecPublicKey),
      );
      return signer.verifySignature(messageBytes, ecSignature);
    } catch (_) {
      return false;
    }
  }

  /// Convert hex string to bytes.
  static Uint8List hexToBytes(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < hex.length; i += 2) {
      result[i ~/ 2] = int.parse(hex.substring(i, i + 2), radix: 16);
    }
    return result;
  }

  static bool _isHexString(String s) => RegExp(r'^[0-9a-fA-F]+$').hasMatch(s);

  static BigInt _bytesToBigInt(Uint8List bytes) {
    var result = BigInt.zero;
    for (final byte in bytes) {
      result = (result << 8) | BigInt.from(byte);
    }
    return result;
  }
}
