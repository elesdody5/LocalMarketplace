sealed class VerificationEvent {}

class VerificationSuccessEvent extends VerificationEvent {}

class VerificationErrorEvent extends VerificationEvent {
  final String message;

  VerificationErrorEvent(this.message);
}

class ResendSuccessEvent extends VerificationEvent {}
