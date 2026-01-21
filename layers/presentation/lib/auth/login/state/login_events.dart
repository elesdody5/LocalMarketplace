sealed class LoginEvent {}

class LoginErrorEvent extends LoginEvent {
  final String message;

  LoginErrorEvent(this.message);
}

class LoginSuccessEvent extends LoginEvent {}
