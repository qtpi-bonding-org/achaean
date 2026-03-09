import 'dart:typed_data';

import 'package:dart_jwk_duo/dart_jwk_duo.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../exceptions/key_exception.dart';
import '../try_operation.dart';
import 'i_key_service.dart';

const _storageKey = 'achaean_jwk_set';

class KeyService implements IKeyService {
  final FlutterSecureStorage _storage;

  KeyService(this._storage);

  @override
  Future<String> generateAndStoreKeypair() {
    return tryMethod(
      () async {
        final duo = await GenerationService.generateKeyDuo();
        final json = await const KeyDuoSerializer().exportKeyDuo(duo);
        await _storage.write(key: _storageKey, value: json);
        return await duo.signingKeyPair.exportPublicKeyHex();
      },
      KeyException.new,
      'generateAndStoreKeypair',
    );
  }

  @override
  Future<String?> getPublicKeyHex() {
    return tryMethod(
      () async {
        final json = await _storage.read(key: _storageKey);
        if (json == null) return null;
        return await KeyDuoSerializer.extractSigningPublicKeyHex(json);
      },
      KeyException.new,
      'getPublicKeyHex',
    );
  }

  @override
  Future<Uint8List> signBytes(Uint8List data) {
    return tryMethod(
      () async {
        final json = requireNonNull(
          await _storage.read(key: _storageKey),
          'stored keypair',
          KeyException.new,
        );
        final duo = await const KeyDuoSerializer().importKeyDuo(json);
        return await duo.signingKeyPair.signBytes(data);
      },
      KeyException.new,
      'signBytes',
    );
  }

  @override
  Future<bool> hasKeypair() {
    return tryMethod(
      () async {
        final json = await _storage.read(key: _storageKey);
        return json != null;
      },
      KeyException.new,
      'hasKeypair',
    );
  }
}
