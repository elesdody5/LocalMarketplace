import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  Future<void> call(String emailOrPhone, String password) async {
    // Placeholder: Implement login logic here
    // This will be connected to an authentication repository later
    await Future.delayed(const Duration(seconds: 2));
    // Simulate successful login
  }
}
