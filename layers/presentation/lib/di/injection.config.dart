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
import 'package:domain/auth/usecase/verification_usecase.dart' as _i773;
import 'package:domain/user_preferences/use_case/get_user_preferences_usecase.dart'
    as _i549;
import 'package:domain/user_preferences/use_case/update_user_preferences.dart'
    as _i780;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../auth/login/login_controller.dart' as _i1020;
import '../auth/signup/signup_controller.dart' as _i518;
import '../auth/verification/verification_controller.dart' as _i532;
import '../splash/splash_controller.dart' as _i121;
import '../welcome/language_controller.dart' as _i224;

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
  gh.factory<_i121.SplashController>(
    () => _i121.SplashController(gh<_i549.GetUserPreferencesUseCase>()),
  );
  gh.factory<_i532.VerificationController>(
    () => _i532.VerificationController(gh<_i773.VerificationUseCase>()),
  );
  gh.factory<_i224.LanguageController>(
    () => _i224.LanguageController(
      gh<_i549.GetUserPreferencesUseCase>(),
      gh<_i780.UpdateUserPreferencesUseCase>(),
    ),
  );
  return getIt;
}
