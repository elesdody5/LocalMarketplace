import 'dart:async';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:injectable/injectable.dart';
import 'package:presentation/auth/verification/state/verification_events.dart';
import 'package:presentation/auth/verification/state/verification_state.dart';

import 'state/verification_actions.dart';

@injectable
class VerificationController extends GetxController {
  final VerificationUseCase verificationUseCase;

  VerificationController(this.verificationUseCase);

  /// Configurable resend cooldown duration in seconds
  static const int resendCooldownSeconds = 60;

  VerificationState _state = const VerificationState();
  Rxn<VerificationEvent> event = Rxn<VerificationEvent>();

  Timer? _resendTimer;

  VerificationState get state => _state;

  /// Set phone number externally (useful for testing or programmatic initialization)
  void setPhoneNumber(String phoneNumber) {
    _state = _state.copyWith(phoneNumber: phoneNumber);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Get phone number from route arguments with null check fallback
    final phoneNumber = (Get.arguments as String?) ?? '';
    _state = _state.copyWith(
      phoneNumber: phoneNumber,
      resendCountdown: resendCooldownSeconds,
      isResendEnabled: false,
    );
    startResendTimer();
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  void verificationAction(VerificationAction action) {
    switch (action) {
      case UpdateCode():
        _handleUpdateCode(action.code);
        break;
      case Verify():
        _handleVerify();
        break;
      case ResendCode():
        _handleResendCode();
        break;
      case UpdateResendCountdown():
        _handleUpdateCountdown(action.countdown);
        break;
    }
  }

  void _handleUpdateCode(String code) {
    // Only allow digits and limit to 6 characters
    final sanitizedCode = code.replaceAll(RegExp(r'\D'), '');
    final limitedCode = sanitizedCode.length > 6
        ? sanitizedCode.substring(0, 6)
        : sanitizedCode;

    _state = _state.copyWith(code: limitedCode);
    update();

    // Trigger haptic feedback when code is complete
    if (_state.isCodeComplete) {
      HapticFeedback.lightImpact();
    }
  }

  void _handleUpdateCountdown(int countdown) {
    _state = _state.copyWith(
      resendCountdown: countdown,
      isResendEnabled: countdown <= 0,
    );
    update();
  }

  Future<void> _handleVerify() async {
    if (!_state.isCodeComplete) {
      event.value = VerificationErrorEvent('error_code_incomplete'.tr);
      HapticFeedback.heavyImpact();
      return;
    }

    try {
      _state = _state.copyWith(isLoading: true);
      update();

      await verificationUseCase.call(_state.phoneNumber, _state.code);

      _state = _state.copyWith(isLoading: false);
      update();

      HapticFeedback.mediumImpact();
      event.value = VerificationSuccessEvent();
    } catch (e) {
      HapticFeedback.heavyImpact();
      event.value = VerificationErrorEvent(e.toString());
      _state = _state.copyWith(isLoading: false);
      // Keep the entered code on error - don't clear it
      update();
    }
  }

  Future<void> _handleResendCode() async {
    if (!_state.isResendEnabled) return;

    try {
      await verificationUseCase.resendCode(_state.phoneNumber);

      // Reset timer
      _state = _state.copyWith(
        resendCountdown: resendCooldownSeconds,
        isResendEnabled: false,
      );
      update();

      startResendTimer();

      HapticFeedback.lightImpact();
      event.value = ResendSuccessEvent();
    } catch (e) {
      HapticFeedback.heavyImpact();
      event.value = VerificationErrorEvent(e.toString());
    }
  }

  void startResendTimer() {
    _resendTimer?.cancel();

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final newCountdown = _state.resendCountdown - 1;

      if (newCountdown <= 0) {
        timer.cancel();
        verificationAction(UpdateResendCountdown(0));
      } else {
        verificationAction(UpdateResendCountdown(newCountdown));
      }
    });
  }

  /// Formats countdown as MM:SS
  String get formattedCountdown {
    final minutes = (_state.resendCountdown ~/ 60).toString().padLeft(2, '0');
    final seconds = (_state.resendCountdown % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
