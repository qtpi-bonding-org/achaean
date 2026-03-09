import 'package:dart_git/dart_git.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// Registers third-party dependencies that injectable can't auto-discover.
@module
abstract class InjectionModule {
  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  // TODO: Read base URL from config/env
  @lazySingleton
  IGitRegistration get gitRegistration => ForgejoRegistration(
        baseUrl: 'http://localhost:3000',
      );
}
