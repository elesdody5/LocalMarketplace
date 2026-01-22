import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';
import 'package:presentation/widgets/primary_button.dart';

/// Verify button widget
/// Disabled until all 6 digits are entered
class VerifyButton extends StatelessWidget {
  final VerificationController controller;
  final Color primaryColor;

  const VerifyButton({
    super.key,
    required this.controller,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      label: 'verify_button'.tr,
      onPressed: controller.state.isCodeComplete && !controller.state.isLoading
          ? () => controller.verificationAction(Verify())
          : null,
      isLoading: controller.state.isLoading,
      isDisabled: !controller.state.isCodeComplete,
      suffixIcon: Icons.arrow_forward,
      borderRadius: 12,
      elevation: 8,
      padding: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
