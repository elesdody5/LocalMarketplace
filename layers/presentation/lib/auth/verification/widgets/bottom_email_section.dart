import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Bottom section with email verification option
/// Provides alternative verification method via email
class BottomEmailSection extends StatelessWidget {
  final Color surfaceTranslucent;
  final Color borderColor;
  final Color onSurfaceMuted;
  final Color primaryColor;
  final TextTheme textTheme;

  const BottomEmailSection({
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
      height: 50,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
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
        child: TextButton.icon(
          onPressed: () {
            Get.snackbar(
              'Coming Soon',
              'Email verification will be available soon',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          icon: Icon(
            Icons.mail_outline,
            size: 20,
            color: onSurfaceMuted,
          ),
          label: Text(
            'verify_via_email'.tr,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: onSurfaceMuted,
            ),
          ),
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
