// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:achaean_flutter/app/injection_module.dart' as _i768;
import 'package:achaean_flutter/design_system/theme/theme_service.dart'
    as _i1040;
import 'package:achaean_flutter/features/account_creation/services/account_creation_message_mapper.dart'
    as _i928;
import 'package:achaean_flutter/features/inspection/services/inspection_message_mapper.dart'
    as _i548;
import 'package:achaean_flutter/features/polis/services/polis_message_mapper.dart'
    as _i224;
import 'package:achaean_flutter/features/post_creation/services/post_creation_message_mapper.dart'
    as _i197;
import 'package:achaean_flutter/features/trust/services/trust_message_mapper.dart'
    as _i37;
import 'package:achaean_flutter/infrastructure/feedback/exception_mapper.dart'
    as _i989;
import 'package:achaean_flutter/infrastructure/feedback/localization_service.dart'
    as _i301;
import 'package:cubit_ui_flow/cubit_ui_flow.dart' as _i653;
import 'package:dart_git/dart_git.dart' as _i667;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.factory<_i928.AccountCreationMessageMapper>(
      () => _i928.AccountCreationMessageMapper(),
    );
    gh.factory<_i197.PostCreationMessageMapper>(
      () => _i197.PostCreationMessageMapper(),
    );
    gh.factory<_i548.InspectionMessageMapper>(
      () => _i548.InspectionMessageMapper(),
    );
    gh.factory<_i37.TrustMessageMapper>(() => _i37.TrustMessageMapper());
    gh.factory<_i224.PolisMessageMapper>(() => _i224.PolisMessageMapper());
    gh.singleton<_i1040.ThemeService>(() => _i1040.ThemeService());
    gh.singleton<_i558.FlutterSecureStorage>(
      () => injectionModule.secureStorage,
    );
    gh.lazySingleton<_i667.IGitRegistration>(
      () => injectionModule.gitRegistration,
    );
    gh.lazySingleton<_i653.ILocalizationService>(
      () => _i301.AppLocalizationService(),
    );
    gh.lazySingleton<_i653.IExceptionKeyMapper>(
      () => _i989.AppExceptionKeyMapper(),
    );
    return this;
  }
}

class _$InjectionModule extends _i768.InjectionModule {}
