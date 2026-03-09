import 'dart:typed_data';

/// Manages ECDSA P-256 keypair lifecycle for signing operations.
abstract class IKeyService {
  /// Generates a new keypair and stores it securely.
  /// Returns the public key as a 128-char hex string.
  Future<String> generateAndStoreKeypair();

  /// Returns the stored public key hex, or null if no keypair exists.
  Future<String?> getPublicKeyHex();

  /// Signs the given bytes with the stored private key (ECDSA P-256).
  Future<Uint8List> signBytes(Uint8List data);

  /// Whether a keypair is currently stored.
  Future<bool> hasKeypair();
}
