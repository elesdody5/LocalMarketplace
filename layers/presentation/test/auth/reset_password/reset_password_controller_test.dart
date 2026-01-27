import 'package:domain/auth/usecase/reset_password_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/auth/reset_password/reset_password_controller.dart';
import 'package:presentation/auth/reset_password/state/reset_password_actions.dart';
import 'package:presentation/auth/reset_password/state/reset_password_events.dart';

import 'reset_password_controller_test.mocks.dart';

@GenerateMocks([ResetPasswordUseCase])
void main() {
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late ResetPasswordController controller;

  setUp(() {
    // Initialize GetX for testing
    Get.testMode = true;

    mockResetPasswordUseCase = MockResetPasswordUseCase();
    controller = ResetPasswordController(mockResetPasswordUseCase);
  });

  tearDown(() {
    controller.onClose();
    Get.reset();
    clearInteractions(mockResetPasswordUseCase);
  });

  group('ResetPasswordController', () {
    group('Initial State', () {
      test('should start with empty passwords and not loading', () {
        expect(controller.state.newPassword, '');
        expect(controller.state.confirmPassword, '');
        expect(controller.state.isLoading, false);
      });

      test('should start with invalid state when passwords are empty', () {
        expect(controller.state.isValid, false);
      });

      test('should start with null event', () {
        expect(controller.event.value, isNull);
      });
    });

    group('SaveNewPassword action', () {
      test('should update newPassword in state when SaveNewPassword action is dispatched', () {
        const testPassword = 'NewPassword123!';

        controller.resetPasswordAction(SaveNewPassword(testPassword));

        expect(controller.state.newPassword, testPassword);
      });

      test('should not affect confirmPassword when updating newPassword', () {
        const testPassword = 'NewPassword123!';
        const confirmPassword = 'OldPassword123!';

        controller.resetPasswordAction(SaveConfirmPassword(confirmPassword));
        controller.resetPasswordAction(SaveNewPassword(testPassword));

        expect(controller.state.newPassword, testPassword);
        expect(controller.state.confirmPassword, confirmPassword);
      });

      test('should allow empty password', () {
        controller.resetPasswordAction(SaveNewPassword(''));

        expect(controller.state.newPassword, '');
      });
    });

    group('SaveConfirmPassword action', () {
      test('should update confirmPassword in state when SaveConfirmPassword action is dispatched', () {
        const testPassword = 'ConfirmPassword123!';

        controller.resetPasswordAction(SaveConfirmPassword(testPassword));

        expect(controller.state.confirmPassword, testPassword);
      });

      test('should not affect newPassword when updating confirmPassword', () {
        const newPassword = 'NewPassword123!';
        const confirmPassword = 'ConfirmPassword123!';

        controller.resetPasswordAction(SaveNewPassword(newPassword));
        controller.resetPasswordAction(SaveConfirmPassword(confirmPassword));

        expect(controller.state.newPassword, newPassword);
        expect(controller.state.confirmPassword, confirmPassword);
      });

      test('should allow empty confirm password', () {
        controller.resetPasswordAction(SaveConfirmPassword(''));

        expect(controller.state.confirmPassword, '');
      });
    });

    group('State Validation (isValid)', () {
      test('should be invalid when password is less than 8 characters', () {
        const shortPassword = 'Short1!';

        controller.resetPasswordAction(SaveNewPassword(shortPassword));
        controller.resetPasswordAction(SaveConfirmPassword(shortPassword));

        expect(controller.state.isValid, false);
      });

      test('should be invalid when passwords do not match', () {
        const password1 = 'Password123!';
        const password2 = 'DifferentPassword123!';

        controller.resetPasswordAction(SaveNewPassword(password1));
        controller.resetPasswordAction(SaveConfirmPassword(password2));

        expect(controller.state.isValid, false);
      });

      test('should be valid when password is 8+ characters and passwords match', () {
        const validPassword = 'ValidPass123!';

        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        expect(controller.state.isValid, true);
      });

      test('should be valid with exactly 8 characters when passwords match', () {
        const password = 'Pass123!';

        controller.resetPasswordAction(SaveNewPassword(password));
        controller.resetPasswordAction(SaveConfirmPassword(password));

        expect(controller.state.isValid, true);
      });

      test('should be invalid when passwords are empty', () {
        controller.resetPasswordAction(SaveNewPassword(''));
        controller.resetPasswordAction(SaveConfirmPassword(''));

        expect(controller.state.isValid, false);
      });

      test('should become invalid when password changes after matching', () {
        const validPassword = 'ValidPass123!';
        const newPassword = 'DifferentPass123!';

        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));
        expect(controller.state.isValid, true);

        controller.resetPasswordAction(SaveNewPassword(newPassword));
        expect(controller.state.isValid, false);
      });
    });

    group('SubmitResetPassword action', () {
      const validPassword = 'ValidPassword123!';

      test('should call usecase with correct password when submit is triggered', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async => Future.value());

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        verify(mockResetPasswordUseCase.call(validPassword)).called(1);
      });

      test('should emit success event when reset password succeeds', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async => Future.value());

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordSuccessEvent>());
      });

      test('should emit error event when reset password fails', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenThrow(Exception('Network error'));

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordErrorEvent>());
      });

      test('should include error message in error event', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        const errorMessage = 'Invalid reset token';
        when(mockResetPasswordUseCase.call(any))
            .thenThrow(Exception(errorMessage));

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        final event = controller.event.value;
        expect(event, isA<ResetPasswordErrorEvent>());
        expect((event as ResetPasswordErrorEvent).message, contains(errorMessage));
      });

      test('should set isLoading to true during password reset', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async {
          await Future.delayed(const Duration(milliseconds: 500));
        });

        controller.resetPasswordAction(SubmitResetPassword());

        // Check loading state immediately
        await Future.delayed(const Duration(milliseconds: 50));
        expect(controller.state.isLoading, true);
      });

      test('should set isLoading to false after successful password reset', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async => Future.value());

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.isLoading, false);
      });

      test('should set isLoading to false after failed password reset', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenThrow(Exception('Error'));

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.isLoading, false);
      });

      test('should maintain password values after successful submit', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async => Future.value());

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.newPassword, validPassword);
        expect(controller.state.confirmPassword, validPassword);
      });

      test('should maintain password values after failed submit', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenThrow(Exception('Error'));

        controller.resetPasswordAction(SubmitResetPassword());

        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.state.newPassword, validPassword);
        expect(controller.state.confirmPassword, validPassword);
      });

      test('should handle multiple submit attempts', () async {
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        when(mockResetPasswordUseCase.call(any))
            .thenThrow(Exception('First error'));

        controller.resetPasswordAction(SubmitResetPassword());
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordErrorEvent>());

        // Try again with success
        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async => Future.value());

        controller.resetPasswordAction(SubmitResetPassword());
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordSuccessEvent>());
        verify(mockResetPasswordUseCase.call(validPassword)).called(2);
      });
    });

    group('Edge Cases', () {
      test('should handle very long passwords', () {
        var longPassword = 'VeryLongPassword123!' * 10; // 200 characters

        controller.resetPasswordAction(SaveNewPassword(longPassword));
        controller.resetPasswordAction(SaveConfirmPassword(longPassword));

        expect(controller.state.newPassword, longPassword);
        expect(controller.state.confirmPassword, longPassword);
        expect(controller.state.isValid, true);
      });

      test('should handle passwords with special characters', () {
        const specialPassword = 'P@ssw0rd!#\$%^&*()_+-=[]{}|;:,.<>?/~`';

        controller.resetPasswordAction(SaveNewPassword(specialPassword));
        controller.resetPasswordAction(SaveConfirmPassword(specialPassword));

        expect(controller.state.newPassword, specialPassword);
        expect(controller.state.confirmPassword, specialPassword);
        expect(controller.state.isValid, true);
      });

      test('should handle passwords with unicode characters', () {
        const unicodePassword = 'Pässwörd123!日本語';

        controller.resetPasswordAction(SaveNewPassword(unicodePassword));
        controller.resetPasswordAction(SaveConfirmPassword(unicodePassword));

        expect(controller.state.newPassword, unicodePassword);
        expect(controller.state.confirmPassword, unicodePassword);
        expect(controller.state.isValid, true);
      });

      test('should handle whitespace in passwords', () {
        const passwordWithSpaces = 'Pass word 123!';

        controller.resetPasswordAction(SaveNewPassword(passwordWithSpaces));
        controller.resetPasswordAction(SaveConfirmPassword(passwordWithSpaces));

        expect(controller.state.newPassword, passwordWithSpaces);
        expect(controller.state.confirmPassword, passwordWithSpaces);
        expect(controller.state.isValid, true);
      });

      test('should handle rapid password updates', () {
        controller.resetPasswordAction(SaveNewPassword('Pass1'));
        controller.resetPasswordAction(SaveNewPassword('Pass12'));
        controller.resetPasswordAction(SaveNewPassword('Pass123'));
        controller.resetPasswordAction(SaveNewPassword('Pass1234'));
        controller.resetPasswordAction(SaveNewPassword('Pass12345'));
        controller.resetPasswordAction(SaveNewPassword('Pass123456'));

        expect(controller.state.newPassword, 'Pass123456');
      });

      test('should handle usecase throwing different error types', () async {
        const validPassword = 'ValidPassword123!';
        controller.resetPasswordAction(SaveNewPassword(validPassword));
        controller.resetPasswordAction(SaveConfirmPassword(validPassword));

        // Test with different error types
        when(mockResetPasswordUseCase.call(any))
            .thenThrow(ArgumentError('Invalid argument'));

        controller.resetPasswordAction(SubmitResetPassword());
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordErrorEvent>());
        expect((controller.event.value as ResetPasswordErrorEvent).message,
            contains('Invalid argument'));
      });
    });

    group('State Management', () {
      test('should notify listeners when state changes', () {
        var updateCount = 0;
        controller.addListener(() => updateCount++);

        controller.resetPasswordAction(SaveNewPassword('NewPass123!'));
        expect(updateCount, greaterThan(0));
      });

      test('should maintain state consistency across multiple actions', () {
        const password1 = 'Password1';
        const password2 = 'Password2';
        const password3 = 'Password3Long';

        controller.resetPasswordAction(SaveNewPassword(password1));
        expect(controller.state.newPassword, password1);
        expect(controller.state.confirmPassword, '');

        controller.resetPasswordAction(SaveConfirmPassword(password2));
        expect(controller.state.newPassword, password1);
        expect(controller.state.confirmPassword, password2);

        controller.resetPasswordAction(SaveNewPassword(password3));
        expect(controller.state.newPassword, password3);
        expect(controller.state.confirmPassword, password2);

        controller.resetPasswordAction(SaveConfirmPassword(password3));
        expect(controller.state.newPassword, password3);
        expect(controller.state.confirmPassword, password3);
        expect(controller.state.isValid, true);
      });

      test('should not mutate previous state', () {
        const password1 = 'Password123!';
        const password2 = 'NewPassword123!';

        controller.resetPasswordAction(SaveNewPassword(password1));
        final state1NewPassword = controller.state.newPassword;

        controller.resetPasswordAction(SaveNewPassword(password2));
        final state2NewPassword = controller.state.newPassword;

        expect(state1NewPassword, password1);
        expect(state2NewPassword, password2);
        expect(state1NewPassword, isNot(equals(state2NewPassword)));
      });
    });

    group('Controller Lifecycle', () {
      test('should properly cleanup on close', () {
        controller.resetPasswordAction(SaveNewPassword('Password123!'));
        controller.resetPasswordAction(SaveConfirmPassword('Password123!'));

        expect(() => controller.onClose(), returnsNormally);
      });

      test('should handle close without initialization', () {
        final newController = ResetPasswordController(mockResetPasswordUseCase);
        expect(() => newController.onClose(), returnsNormally);
      });

      test('should be reusable after multiple operations', () async {
        const password1 = 'FirstPassword123!';
        const password2 = 'SecondPassword123!';

        // First operation
        controller.resetPasswordAction(SaveNewPassword(password1));
        controller.resetPasswordAction(SaveConfirmPassword(password1));

        when(mockResetPasswordUseCase.call(any))
            .thenAnswer((_) async => Future.value());

        controller.resetPasswordAction(SubmitResetPassword());
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordSuccessEvent>());

        // Second operation
        controller.resetPasswordAction(SaveNewPassword(password2));
        controller.resetPasswordAction(SaveConfirmPassword(password2));

        controller.resetPasswordAction(SubmitResetPassword());
        await Future.delayed(const Duration(milliseconds: 100));

        expect(controller.event.value, isA<ResetPasswordSuccessEvent>());
        verify(mockResetPasswordUseCase.call(password1)).called(1);
        verify(mockResetPasswordUseCase.call(password2)).called(1);
      });
    });
  });
}
