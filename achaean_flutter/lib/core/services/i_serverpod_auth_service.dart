/// Provides Koinon auth headers for Serverpod requests.
abstract class IServerpodAuthService {
  /// Generate auth headers (pubkey, timestamp, signature) for a Serverpod request.
  Future<Map<String, String>> getAuthHeaders();
}
