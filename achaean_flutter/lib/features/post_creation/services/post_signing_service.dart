import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_koinon/dart_koinon.dart';
import '../../../core/services/i_key_service.dart';
import 'i_post_signing_service.dart';

class PostSigningService implements IPostSigningService {
  final IKeyService _keyService;

  PostSigningService(this._keyService);

  @override
  Future<String> signPost(Post unsignedPost) async {
    final map = Map<String, dynamic>.from(unsignedPost.toJson())
      ..remove('signature');

    final canonicalBytes = Uint8List.fromList(utf8.encode(jsonEncode(map)));
    final signatureBytes = await _keyService.signBytes(canonicalBytes);

    return base64Url.encode(signatureBytes).replaceAll('=', '');
  }
}
