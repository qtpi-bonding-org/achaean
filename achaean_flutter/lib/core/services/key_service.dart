import 'dart:typed_data';

import 'package:dart_jwk_duo/dart_jwk_duo.dart';

import '../exceptions/key_exception.dart';
import '../try_operation.dart';
import 'i_key_service.dart';
import 'secure_preferences.dart';

class KeyService implements IKeyService {
  final SecurePreferences _prefs;

  KeyService(this._prefs);

  @override
  Future<String> generateAndStoreKeypair() {
    return tryMethod(
      () async {
        final duo = await GenerationService.generateKeyDuo();
        final json = await const KeyDuoSerializer().exportKeyDuo(duo);
        await _prefs.setKeypairJwk(json);
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
        final json = await _prefs.getKeypairJwk();
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
          await _prefs.getKeypairJwk(),
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
      () => _prefs.hasKeypair(),
      KeyException.new,
      'hasKeypair',
    );
  }
}
