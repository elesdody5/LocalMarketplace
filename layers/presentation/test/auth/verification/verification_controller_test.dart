import 'package:domain/auth/usecase/verification_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';
import 'package:presentation/auth/verification/state/verification_events.dart';
import 'package:presentation/auth/verification/state/verification_state.dart';
import 'package:presentation/routes/auth_routes.dart';

import 'verification_controller_test.mocks.dart';

@GenerateMocks([VerificationUseCase, ResendVerificationCodeUseCase])
void main() {
  late MockVerificationUseCase mockVerificationUseCase;
  late MockResendVerificationCodeUseCase mockResendVerificationCodeUseCase;
  late VerificationController controller;

  const testPhoneNumber = '+1234567890';
  const testEmail = 'test@example.com';

  setUp(() {
    // Initialize GetX for translations and arguments
    Get.testMode = true;

    mockVerificationUseCase = MockVerificationUseCase();
    mockResendVerificationCodeUseCase = MockResendVerificationCodeUseCase();
    controller = VerificationController(mockVerificationUseCase, mockResendVerificationCodeUseCase);
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

        when(mockVerificationUseCase.call(any, any, any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(Verify());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<VerificationSuccessEvent>());
      });

      test('should emit error event when verification fails', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any, any))
            .thenThrow(Exception('Invalid code'));

        controller.verificationAction(Verify());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<VerificationErrorEvent>());
      });

      test('should keep code in state after verification error', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any, any))
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
        verifyNever(mockVerificationUseCase.call(any, any, any));
      });

      test('should set isLoading to true during verification', () async {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any, any))
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

        when(mockVerificationUseCase.call(any, any, any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(Verify());

        // Wait for async operation to complete
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.isLoading, false);
      });
    });

    group('ResendCode action', () {
      test('should emit ResendSuccessEvent when resend succeeds', () async {
        // Set phone and email AFTER onInit to override Get.arguments
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);

        // Wait for countdown to complete (or force enable)
        controller.verificationAction(UpdateResendCountdown(0));

        when(mockResendVerificationCodeUseCase(any,any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(ResendCode());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResendSuccessEvent>());
        verify(mockResendVerificationCodeUseCase(
          VerificationType.phone,
          testPhoneNumber,
        )).called(1);
      });

      test('should not resend when countdown is active', () async {
        controller.onInit();

        // Countdown is active (not 0)
        expect(controller.state.isResendEnabled, false);

        controller.verificationAction(ResendCode());

        // Wait for async operation
        await Future.delayed(const Duration(milliseconds: 100));

        verifyNever(mockResendVerificationCodeUseCase(any,any));
      });

      test('should reset countdown after successful resend', () async {
        controller.onInit();
        controller.verificationAction(UpdateResendCountdown(0));

        when(mockResendVerificationCodeUseCase(any,any))
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
        controller.onInit();
        expect(controller.state.resendCountdown, VerificationController.resendCooldownSeconds);
      });

      test('should decrement countdown over time', () async {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);

        final initialCountdown = controller.state.resendCountdown;

        // Wait for 2 seconds
        await Future.delayed(const Duration(seconds: 2));

        expect(controller.state.resendCountdown, lessThan(initialCountdown));
      });

      test('should enable resend when countdown reaches 0', () async {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);

        // Manually set countdown to 1
        controller.verificationAction(UpdateResendCountdown(1));

        // Wait for countdown to finish
        await Future.delayed(const Duration(seconds: 2));

        expect(controller.state.isResendEnabled, true);
      });

      test('formattedCountdown should return MM:SS format', () {
        controller.onInit();

        controller.verificationAction(UpdateResendCountdown(65)); // 1:05
        expect(controller.formattedCountdown, '01:05');

        controller.verificationAction(UpdateResendCountdown(5)); // 0:05
        expect(controller.formattedCountdown, '00:05');

        controller.verificationAction(UpdateResendCountdown(0)); // 0:00
        expect(controller.formattedCountdown, '00:00');
      });
    });

    group('Initialization and Arguments', () {
      test('should initialize with phone and email from arguments', () {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);

        expect(controller.state.phoneNumber, testPhoneNumber);
        expect(controller.state.email, testEmail);
      });

      test('should default to phone verification type', () {
        controller.onInit();
        expect(controller.state.verificationType, VerificationType.phone);
      });

      test('should handle empty arguments gracefully', () {
        final testController = VerificationController(mockVerificationUseCase, mockResendVerificationCodeUseCase);
        // Don't set any values - state should have empty defaults

        expect(testController.state.phoneNumber, '');
        expect(testController.state.email, '');
        expect(testController.state.verificationType, VerificationType.phone);
        testController.onClose();
      });

      test('should handle missing phone in arguments', () {
        final testController = VerificationController(mockVerificationUseCase, mockResendVerificationCodeUseCase);
        testController.setEmail(testEmail);
        // Don't set phone - it should remain empty

        expect(testController.state.phoneNumber, '');
        expect(testController.state.email, testEmail);
        testController.onClose();
      });

      test('should handle missing email in arguments', () {
        final testController = VerificationController(mockVerificationUseCase, mockResendVerificationCodeUseCase);
        testController.setPhoneNumber(testPhoneNumber);
        // Don't set email - it should remain empty

        expect(testController.state.phoneNumber, testPhoneNumber);
        expect(testController.state.email, '');
        testController.onClose();
      });
    });

    group('Masked Email', () {
      test('should mask email showing first character and domain', () {
        controller.onInit();
        controller.setEmail('john@example.com');
        expect(controller.state.maskedEmail, 'j***@example.com');
      });

      test('should handle short email username', () {
        controller.onInit();
        controller.setEmail('a@test.com');
        expect(controller.state.maskedEmail, 'a***@test.com');
      });

      test('should handle empty email', () {
        controller.onInit();
        controller.setEmail('');
        expect(controller.state.maskedEmail, 'a***@example.com');
      });

      test('should handle invalid email format', () {
        controller.onInit();
        controller.setEmail('invalidemail');
        expect(controller.state.maskedEmail, 'a***@example.com');
      });
    });

    group('SwitchVerificationType action', () {
      test('should switch from phone to email', () {
        controller.onInit();
        expect(controller.state.verificationType, VerificationType.phone);

        controller.verificationAction(SwitchVerificationType());

        expect(controller.state.verificationType, VerificationType.email);
      });

      test('should switch from email to phone', () {
        controller.onInit();
        controller.verificationAction(SwitchVerificationType());
        expect(controller.state.verificationType, VerificationType.email);

        controller.verificationAction(SwitchVerificationType());

        expect(controller.state.verificationType, VerificationType.phone);
      });

      test('should clear code when switching verification type', () {
        controller.onInit();
        controller.verificationAction(UpdateCode('123456'));
        expect(controller.state.code, '123456');

        controller.verificationAction(SwitchVerificationType());

        expect(controller.state.code, '');
      });

      test('should reset countdown when switching', () {
        controller.onInit();
        controller.verificationAction(UpdateResendCountdown(30));
        expect(controller.state.resendCountdown, 30);

        controller.verificationAction(SwitchVerificationType());

        expect(controller.state.resendCountdown, VerificationController.resendCooldownSeconds);
        expect(controller.state.isResendEnabled, false);
      });
    });

    group('Verification with Email', () {
      test('should verify with email when email type is active', () async {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);
        controller.verificationAction(SwitchVerificationType());
        controller.verificationAction(UpdateCode('123456'));

        when(mockVerificationUseCase.call(any, any, any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(Verify());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<VerificationSuccessEvent>());
        verify(mockVerificationUseCase.call(
          VerificationType.email,
          testEmail,
          '123456',
        )).called(1);
      });

      test('should resend code to email when email type is active', () async {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);
        controller.verificationAction(SwitchVerificationType());
        controller.verificationAction(UpdateResendCountdown(0));

        when(mockResendVerificationCodeUseCase(any,any))
            .thenAnswer((_) async => Future.value());

        controller.verificationAction(ResendCode());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResendSuccessEvent>());
        verify(mockResendVerificationCodeUseCase(
          VerificationType.email,
          testEmail,
        )).called(1);
      });
    });

    group('Current Contact', () {
      test('should return phone number when phone type is active', () {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);
        expect(controller.state.currentContact, testPhoneNumber);
      });

      test('should return email when email type is active', () {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);
        controller.verificationAction(SwitchVerificationType());
        expect(controller.state.currentContact, testEmail);
      });
    });

    group('Masked Contact', () {
      test('should return masked phone when phone type is active', () {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);
        expect(controller.state.maskedContact, controller.state.maskedPhoneNumber);
      });

      test('should return masked email when email type is active', () {
        controller.onInit();
        controller.setPhoneNumber(testPhoneNumber);
        controller.setEmail(testEmail);
        controller.verificationAction(SwitchVerificationType());
        expect(controller.state.maskedContact, controller.state.maskedEmail);
      });
    });
  });
}
