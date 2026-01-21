// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/auth/auth_repository.dart' as _i719;
import 'package:domain/user_preferences/user_preferences_repository.dart'
    as _i578;
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;

import '../auth/auth_repository_impl.dart' as _i790;
import '../user_preferences/preferences/user_preferences_data_source.dart'
    as _i821;
import '../user_preferences/user_preferences_repository_imp.dart' as _i541;
import 'data_module.dart' as _i444;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initDataGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final dataModule = _$DataModule();
  gh.lazySingleton<_i792.GetStorage>(() => dataModule.getStorage);
  gh.factory<_i719.AuthRepository>(() => _i790.AuthRepositoryImpl());
  gh.factory<_i821.UserPreferencesDataSource>(
    () => _i821.UserPreferencesDataSource(gh<_i792.GetStorage>()),
  );
  gh.factory<_i578.UserPreferencesRepository>(
    () => _i541.UserPreferencesRepositoryImp(
      gh<_i821.UserPreferencesDataSource>(),
    ),
  );
  return getIt;
}

class _$DataModule extends _i444.DataModule {}
