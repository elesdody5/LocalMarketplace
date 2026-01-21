// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/auth/usecase/login_usecase.dart' as _i926;
import 'package:domain/auth/usecase/signup_usecase.dart' as _i472;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../auth/login/login_controller.dart' as _i1020;
import '../auth/signup/signup_controller.dart' as _i518;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initPresentationGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i518.SignupController>(
    () => _i518.SignupController(gh<_i472.SignupUseCase>()),
  );
  gh.factory<_i1020.LoginController>(
    () => _i1020.LoginController(gh<_i926.LoginUseCase>()),
  );
  return getIt;
}
