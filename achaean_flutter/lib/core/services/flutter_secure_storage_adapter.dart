import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'i_secure_storage.dart';

/// Adapts [FlutterSecureStorage] to the [ISecureStorage] interface.
class FlutterSecureStorageAdapter implements ISecureStorage {
  final FlutterSecureStorage _storage;

  const FlutterSecureStorageAdapter(this._storage);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<bool> containsKey(String key) => _storage.containsKey(key: key);
}
