// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../auth/auth_repository.dart' as _i778;
import '../auth/usecase/login_usecase.dart' as _i120;
import '../auth/usecase/signup_usecase.dart' as _i734;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initDomainGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i120.LoginUseCase>(() => _i120.LoginUseCase());
  gh.factory<_i734.SignupUseCase>(
    () => _i734.SignupUseCase(gh<_i778.AuthRepository>()),
  );
  return getIt;
}
