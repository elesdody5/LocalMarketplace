import 'package:injectable/injectable.dart';

@injectable
class VerificationUseCase {
  /// Verifies the code sent to the phone number
  /// Returns successfully if verification passes, throws error otherwise
  Future<void> call(String phoneNumber, String code) async {
    // Placeholder: Implement verification logic here
    // This will be connected to an authentication repository later
    await Future.delayed(const Duration(seconds: 2));

    // Simulate successful verification
    // In real implementation, this would call the backend API
  }

  /// Resends the verification code to the phone number
  Future<void> resendCode(String phoneNumber) async {
    // Placeholder: Implement resend code logic here
    await Future.delayed(const Duration(seconds: 1));

    // Simulate successful resend
  }
}
