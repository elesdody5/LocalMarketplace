sealed class SignupEvent {}

class SignupErrorEvent extends SignupEvent {
  final String message;

  SignupErrorEvent(this.message);
}

class SignupSuccessEvent extends SignupEvent {}