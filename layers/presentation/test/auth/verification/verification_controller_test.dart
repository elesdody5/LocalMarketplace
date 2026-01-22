import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';
import 'package:presentation/auth/verification/state/verification_events.dart';

import 'verification_controller_test.mocks.dart';

@GenerateMocks([VerificationUseCase])
void main() {
  late MockVerificationUseCase mockVerificationUseCase;
  late VerificationController controller;

  const testPhoneNumber = '+1234567890';

  setUp(() {
    // Initialize GetX for translations and arguments
    Get.testMode = true;

    mockVerificationUseCase = MockVerificationUseCase();
    controller = VerificationController(mockVerificationUseCase);

    // Mock Get.arguments to return test phone number
    Get.parameters = {'phone': testPhoneNumber};
    // Note: Since we can't directly set Get.arguments in tests,
    // we need to initialize the state manually for testing
    controller.onInit();
  });

  tearDown(() {
    controller.onClose();
    Get.reset();
    clearInteractions(mockVerificationUseCase);
  });

  group('VerificationController', () {
    group('UpdateCode action', () {
      test('should update code in state when UpdateCode action is dispatched', () {
        controller.onInit();

        controller.verificationAction(UpdateCode('123456'));

        expect(controller.state.code, '123456');
      });

      test('should only allow digits in code', () {
        controller.onInit();

        controller.verificationAction(UpdateCode('12a3b4c'));

        expect(controller.state.code, '1234');
      });

      test('should limit code to 6 characters', () {
        controller.onInit();

        controller.verificationAction(UpdateCode('12345678'));

        expect(controller.state.code, '123456');
      });

      test('isCodeComplete should return true when code has 6 digits', () {
        controller.onInit();

        controller.verificationAction(UpdateCode('123456'));

        expect(controller.state.isCodeComplete, true);
      });

      test('isCodeComplete should return false when code has less than 6 digits', () {
        controller.onInit();

        controller.verificationAction(UpdateCode('12345'));

        expect(controller.state.isCodeComplete, false);
      });
    });

    group('Verify action', () {
      test('should emit success event when verification succeeds', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(Verify());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<VerificationSuccessEvent>());
        verify(mockVerificationUseCase.call(testPhoneNumber, '123456')).called(1);
      });

      test('should emit error event when verification fails', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any))
            .thenThrow(Exception('Invalid code'));

        controller.verificationAction(Verify());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<VerificationErrorEvent>());
      });

      test('should keep code in state after verification error', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any))
            .thenThrow(Exception('Invalid code'));

        controller.verificationAction(Verify());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        // Code should still be in state
        expect(controller.state.code, '123456');
      });

      test('should emit error event when code is incomplete', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('12345')); // Only 5 digits

        controller.verificationAction(Verify());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<VerificationErrorEvent>());
        verifyNever(mockVerificationUseCase.call(any, any));
      });

      test('should set isLoading to true during verification', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any))
            .thenAnswer((_) async {
              await Future.delayed(const Duration(milliseconds: 500));
            });

        controller.verificationAction(Verify());

        // Check loading state immediately
        await Future.delayed(const Duration(milliseconds: 50));
        expect(controller.state.isLoading, true);
      });

      test('should set isLoading to false after verification completes', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(Verify());

        // Wait for async operation to complete
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.isLoading, false);
      });
    });

    group('ResendCode action', () {
      test('should emit ResendSuccessEvent when resend succeeds', () async {
        controller.onInit();

        // Wait for countdown to complete (or force enable)
        controller.verificationAction(UpdateResendCountdown(0));

        when(mockVerificationUseCase.resendCode(any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(ResendCode());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResendSuccessEvent>());
        verify(mockVerificationUseCase.resendCode(testPhoneNumber)).called(1);
      });

      test('should not resend when countdown is active', () async {
        controller.onInit();

        // Countdown is active (not 0)
        expect(controller.state.isResendEnabled, false);

        controller.verificationAction(ResendCode());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        verifyNever(mockVerificationUseCase.resendCode(any));
      });

      test('should reset countdown after successful resend', () async {
        controller.onInit();
        controller.verificationAction(UpdateResendCountdown(0));

        when(mockVerificationUseCase.resendCode(any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(ResendCode());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.resendCountdown, VerificationController.resendCooldownSeconds);
        expect(controller.state.isResendEnabled, false);
      });
    });

    group('Timer functionality', () {
      test('should start with correct countdown value', () {
        expect(controller.state.resendCountdown, VerificationController.resendCooldownSeconds);
      });

      test('should decrement countdown over time', () async {
        final initialCountdown = controller.state.resendCountdown;

        // Wait for 2 seconds
        await Future.delayed(const Duration(seconds: 2));

        expect(controller.state.resendCountdown, lessThan(initialCountdown));
      });

      test('should enable resend when countdown reaches 0', () async {
        // Manually set countdown to 1
        controller.verificationAction(UpdateResendCountdown(1));

        // Wait for countdown to finish
        await Future.delayed(const Duration(seconds: 2));

        expect(controller.state.isResendEnabled, true);
      });

      test('formattedCountdown should return MM:SS format', () {

        controller.verificationAction(UpdateResendCountdown(65)); // 1:05
        expect(controller.formattedCountdown, '01:05');

        controller.verificationAction(UpdateResendCountdown(5)); // 0:05
        expect(controller.formattedCountdown, '00:05');

        controller.verificationAction(UpdateResendCountdown(0)); // 0:00
        expect(controller.formattedCountdown, '00:00');
      });
    });

    group('Phone number handling', () {
      test('should get phone number that was set', () {
        expect(controller.state.phoneNumber, testPhoneNumber);
      });

      test('should use empty string when phone is not set', () {
        final testController = VerificationController(mockVerificationUseCase);
        testController.onInit();

        expect(testController.state.phoneNumber, '');
        testController.onClose();
      });

      test('maskedPhoneNumber should show last 4 digits', () {
        // Phone: +1234567890, last 4 digits: 7890
        expect(controller.state.maskedPhoneNumber, '***-***-7890');
      });

      test('maskedPhoneNumber should show placeholder when phone is empty', () {
        final testController = VerificationController(mockVerificationUseCase);
        testController.setPhoneNumber('');

        expect(testController.state.maskedPhoneNumber, '***-***-****');
        testController.onClose();
      });
    });
  });
}
