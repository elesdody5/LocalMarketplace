import 'package:domain/auth/auth_repository.dart';
import 'package:domain/user/entity/user.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupUseCase {
  final AuthRepository _authRepository;

  SignupUseCase(this._authRepository);

  Future<void> call(User user, String password) async {
    await _authRepository.signup(user, password);
  }
}
