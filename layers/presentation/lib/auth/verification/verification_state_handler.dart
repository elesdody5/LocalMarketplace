import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/verification/verification_screen.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/widgets/error_snackbar.dart';

import 'state/verification_events.dart';

extension VerificationStateHandler on VerificationScreen {

  void observeVerificationEvents(Rxn<VerificationEvent> event) {
    ever(event, (value) {
      if (value is VerificationSuccessEvent) {
        HapticFeedback.mediumImpact();
        // Navigate to home screen using offAllNamed to prevent back navigation
        Get.offAllNamed(homeRouteName);
      } else if (value is VerificationErrorEvent) {
        HapticFeedback.heavyImpact();
        ErrorSnackbar.showValidationError(message: value.message);
      } else if (value is ResendSuccessEvent) {
        HapticFeedback.lightImpact();
        Get.snackbar(
          'success'.tr,
          'code_resent_success'.tr,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.9),
          colorText: Get.theme.colorScheme.onPrimary,
          duration: const Duration(seconds: 2),
        );
      }
    });
  }
}
