import 'dart:convert';
import 'dart:typed_data';

import '../exceptions/key_exception.dart';
import '../try_operation.dart';
import 'i_key_service.dart';
import 'i_signing_service.dart';

class SigningService implements ISigningService {
  final IKeyService _keyService;

  SigningService(this._keyService);

  @override
  Future<String> sign(Map<String, dynamic> json) {
    return tryMethod(
      () async {
        final map = Map<String, dynamic>.from(json)..remove('signature');
        final canonicalBytes =
            Uint8List.fromList(utf8.encode(jsonEncode(map)));
        final signatureBytes = await _keyService.signBytes(canonicalBytes);
        return base64Url.encode(signatureBytes).replaceAll('=', '');
      },
      KeyException.new,
      'sign',
    );
  }
}
