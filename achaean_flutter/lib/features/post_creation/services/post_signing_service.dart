import 'package:dart_koinon/dart_koinon.dart';

import '../../../core/services/i_signing_service.dart';
import 'i_post_signing_service.dart';

class PostSigningService implements IPostSigningService {
  final ISigningService _signingService;

  PostSigningService(this._signingService);

  @override
  Future<String> signPost(Post unsignedPost) {
    return _signingService.sign(unsignedPost.toJson());
  }
}
