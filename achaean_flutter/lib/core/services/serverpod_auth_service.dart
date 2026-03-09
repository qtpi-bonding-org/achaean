import 'dart:convert';
import 'dart:typed_data';

import 'i_key_service.dart';
import 'i_serverpod_auth_service.dart';

class ServerpodAuthService implements IServerpodAuthService {
  final IKeyService _keyService;

  ServerpodAuthService(this._keyService);

  @override
  Future<Map<String, String>> getAuthHeaders() async {
    final pubkey = await _keyService.getPublicKeyHex();
    if (pubkey == null) throw Exception('No keypair available');

    final timestamp = DateTime.now().toUtc().toIso8601String();
    final timestampBytes = Uint8List.fromList(utf8.encode(timestamp));
    final signatureBytes = await _keyService.signBytes(timestampBytes);

    // Convert signature to hex (CryptoAuth expects hex, not base64url)
    final signatureHex = signatureBytes
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return {
      'X-Koinon-Pubkey': pubkey,
      'X-Koinon-Timestamp': timestamp,
      'X-Koinon-Signature': signatureHex,
    };
  }
}
