/// Platform-agnostic secure storage interface.
/// Wrap platform implementations (e.g. FlutterSecureStorage) behind this
/// so services can be tested without the Flutter plugin.
abstract class ISecureStorage {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
  Future<bool> containsKey(String key);
}
