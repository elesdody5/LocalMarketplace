sealed class VerificationAction {}

class UpdateCode extends VerificationAction {
  final String code;

  UpdateCode(this.code);
}

class Verify extends VerificationAction {}

class ResendCode extends VerificationAction {}

class UpdateResendCountdown extends VerificationAction {
  final int countdown;

  UpdateResendCountdown(this.countdown);
}
