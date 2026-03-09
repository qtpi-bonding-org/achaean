/// Generic canonical-JSON signing service.
///
/// Takes any JSON map, removes the `signature` key, encodes to canonical JSON,
/// signs via IKeyService, and returns a base64url-encoded signature string.
abstract class ISigningService {
  /// Signs the given JSON map and returns the base64url-encoded signature.
  Future<String> sign(Map<String, dynamic> json);
}
