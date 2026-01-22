class VerificationState {
  final String code;
  final bool isLoading;
  final bool isResendEnabled;
  final String phoneNumber;
  final int resendCountdown;

  const VerificationState({
    this.code = '',
    this.isLoading = false,
    this.isResendEnabled = false,
    this.phoneNumber = '',
    this.resendCountdown = 60,
  });

  /// Returns true if all 6 digits have been entered
  bool get isCodeComplete => code.length == 6;

  /// Returns masked phone number showing only last 4 digits
  /// Example: "***-***-4567"
  String get maskedPhoneNumber {
    if (phoneNumber.isEmpty) {
      return '***-***-****';
    }

    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 4) {
      return '***-***-****';
    }

    // Get last 4 digits
    final lastFour = digitsOnly.substring(digitsOnly.length - 4);
    return '***-***-$lastFour';
  }

  VerificationState copyWith({
    String? code,
    bool? isLoading,
    bool? isResendEnabled,
    String? phoneNumber,
    int? resendCountdown,
  }) {
    return VerificationState(
      code: code ?? this.code,
      isLoading: isLoading ?? this.isLoading,
      isResendEnabled: isResendEnabled ?? this.isResendEnabled,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      resendCountdown: resendCountdown ?? this.resendCountdown,
    );
  }
}
