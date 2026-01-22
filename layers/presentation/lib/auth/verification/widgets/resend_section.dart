import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';

/// Resend code section with countdown timer
/// Shows countdown and allows resending code when enabled
class ResendSection extends StatelessWidget {
  final VerificationController controller;
  final Color onSurfaceMuted;
  final Color primaryColor;
  final TextTheme textTheme;
  final bool isDark;

  const ResendSection({
    super.key,
    required this.controller,
    required this.onSurfaceMuted,
    required this.primaryColor,
    required this.textTheme,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final buttonBackground = isDark
        ? Colors.grey.shade800
        : Colors.grey.shade100;
    final buttonHoverBackground = isDark
        ? Colors.grey.shade700
        : Colors.grey.shade200;

    return Column(
      children: [
        Text(
          'didnt_receive_code'.tr,
          style: textTheme.bodySmall?.copyWith(
            color: onSurfaceMuted,
          ),
        ),
        const SizedBox(height: 8),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: controller.state.isResendEnabled
                ? () => controller.verificationAction(ResendCode())
                : null,
            borderRadius: BorderRadius.circular(20),
            splashColor: primaryColor.withValues(alpha: 0.1),
            highlightColor: buttonHoverBackground,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: buttonBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.refresh,
                    size: 18,
                    color: controller.state.isResendEnabled
                        ? primaryColor
                        : onSurfaceMuted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    controller.state.isResendEnabled
                        ? 'resend_code'.tr
                        : '${'resend_in'.tr} ${controller.formattedCountdown}',
                    style: textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: controller.state.isResendEnabled
                          ? primaryColor
                          : Get.theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
