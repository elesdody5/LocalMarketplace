import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/routes/auth_routes.dart';

/// Bottom section with signup link
/// Prompts users to create an account if they don't have one
class BottomSignupSection extends StatelessWidget {
  final Color surfaceTranslucent;
  final Color borderColor;
  final Color onSurfaceMuted;
  final Color primaryColor;
  final TextTheme textTheme;

  const BottomSignupSection({
    super.key,
    required this.surfaceTranslucent,
    required this.borderColor,
    required this.onSurfaceMuted,
    required this.primaryColor,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: surfaceTranslucent,
        border: Border(
          top: BorderSide(
            color: borderColor,
            width: 1,
          ),
        ),
      ),
      child: Center(
        // ✅ Replace RichText with simple Row
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'dont_have_account'.tr,
              style: textTheme.bodyMedium?.copyWith(
                color: onSurfaceMuted,
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => Get.offNamed(signupRouteName),
              child: Text(
                'sign_up'.tr,
                style: textTheme.bodyMedium?.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
