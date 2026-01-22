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
import '../auth/usecase/verification_usecase.dart' as _i375;
import '../user_preferences/use_case/get_user_preferences_usecase.dart'
    as _i679;
import '../user_preferences/use_case/update_user_preferences.dart' as _i892;
import '../user_preferences/user_preferences_repository.dart' as _i524;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initDomainGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.factory<_i120.LoginUseCase>(() => _i120.LoginUseCase());
  gh.factory<_i375.VerificationUseCase>(() => _i375.VerificationUseCase());
  gh.factory<_i734.SignupUseCase>(
    () => _i734.SignupUseCase(gh<_i778.AuthRepository>()),
  );
  gh.factory<_i679.GetUserPreferencesUseCase>(
    () =>
        _i679.GetUserPreferencesUseCase(gh<_i524.UserPreferencesRepository>()),
  );
  gh.factory<_i892.UpdateUserPreferencesUseCase>(
    () => _i892.UpdateUserPreferencesUseCase(
      gh<_i524.UserPreferencesRepository>(),
    ),
  );
  return getIt;
}
