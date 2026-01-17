import 'package:domain/auth/usecase/signup_usecase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DomainModule {
  @factoryMethod
  SignupUseCase provideSignupUseCase() => SignupUseCase();
}
