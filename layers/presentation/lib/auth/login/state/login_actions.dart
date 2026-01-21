sealed class LoginAction {}

class Login extends LoginAction {}

class SaveLoginCredentials extends LoginAction {
  final String? emailOrPhone;
  final String? password;

  SaveLoginCredentials({
    this.emailOrPhone,
    this.password,
  });
}
