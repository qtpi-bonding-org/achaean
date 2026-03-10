import 'dart:convert';
import 'dart:typed_data';

import 'package:serverpod_client/serverpod_client.dart';

import 'i_key_service.dart';

/// Stateless Koinon auth token manager for Serverpod.
///
/// Generates a fresh `pubkey:timestamp:signatureHex` token on every request.
/// Serverpod sends this as the Authorization header, and the server's
/// [KoinonAuthHandler] verifies it.
///
/// No sessions, no stored tokens. [put] and [remove] are no-ops.
// ignore: deprecated_member_use
class KoinonKeyManager extends AuthenticationKeyManager {
  final IKeyService _keyService;

  KoinonKeyManager(this._keyService);

  @override
  Future<String?> get() async {
    final pubkey = await _keyService.getPublicKeyHex();
    if (pubkey == null) return null;

    final timestamp = DateTime.now().toUtc().toIso8601String();
    final timestampBytes = Uint8List.fromList(utf8.encode(timestamp));
    final signatureBytes = await _keyService.signBytes(timestampBytes);

    final signatureHex = signatureBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return '$pubkey:$timestamp:$signatureHex';
  }

  @override
  Future<void> put(String key) async {
    // No-op: stateless auth, no tokens to store.
  }

  @override
  Future<void> remove() async {
    // No-op: stateless auth, no tokens to remove.
  }

  @override
  Future<String?> toHeaderValue(String? key) async {
    if (key == null) return null;
    return 'Bearer $key';
  }
}
