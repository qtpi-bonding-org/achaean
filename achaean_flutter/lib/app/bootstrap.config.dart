// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:achaean_flutter/design_system/theme/theme_service.dart'
    as _i1040;
import 'package:achaean_flutter/infrastructure/feedback/exception_mapper.dart'
    as _i989;
import 'package:achaean_flutter/infrastructure/feedback/localization_service.dart'
    as _i301;
import 'package:cubit_ui_flow/cubit_ui_flow.dart' as _i653;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.singleton<_i1040.ThemeService>(() => _i1040.ThemeService());
    gh.lazySingleton<_i653.ILocalizationService>(
      () => _i301.AppLocalizationService(),
    );
    gh.lazySingleton<_i653.IExceptionKeyMapper>(
      () => _i989.AppExceptionKeyMapper(),
    );
    return this;
  }
}
