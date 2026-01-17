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

import '../auth/usecase/signup_usecase.dart' as _i734;
import 'domain_module.dart' as _i435;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt initDomainGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final domainModule = _$DomainModule();
  gh.factory<_i734.SignupUseCase>(() => domainModule.provideSignupUseCase());
  return getIt;
}

class _$DomainModule extends _i435.DomainModule {}
