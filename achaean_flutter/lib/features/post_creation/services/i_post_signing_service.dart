import 'package:dart_koinon/dart_koinon.dart';

/// Signs posts using the stored ECDSA keypair.
abstract class IPostSigningService {
  /// Signs a post and returns the base64url-encoded signature string.
  Future<String> signPost(Post unsignedPost);
}
