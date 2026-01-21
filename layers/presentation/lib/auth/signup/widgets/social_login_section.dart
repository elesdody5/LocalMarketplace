import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/theme/app_text_styles.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final dividerColor = isDark ? AppColors.dividerDark : AppColors.dividerLight;
    final textSecondaryColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final textPrimaryColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final surfaceColor = isDark ? AppColors.surfaceDark : Colors.white;

    return Column(
      children: [
        // Divider with "Or continue with" text
        Row(
          children: [
            Expanded(
              child: Divider(
                color: dividerColor,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'or_continue_with'.tr,
                style: AppTextStyles.bodySmall.copyWith(
                  color: textSecondaryColor,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: dividerColor,
                thickness: 1,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Social Login Buttons
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                label: 'google_button'.tr,
                icon: Icons.g_mobiledata,
                iconColor: const Color(0xFFDB4437),
                textColor: textPrimaryColor,
                surfaceColor: surfaceColor,
                borderColor: dividerColor,
                onPressed: () {
                  Get.snackbar(
                    'Coming Soon',
                    'Google sign in will be available soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _SocialButton(
                label: 'facebook_button'.tr,
                icon: Icons.facebook,
                iconColor: const Color(0xFF1877F2),
                textColor: textPrimaryColor,
                surfaceColor: surfaceColor,
                borderColor: dividerColor,
                onPressed: () {
                  Get.snackbar(
                    'Coming Soon',
                    'Facebook sign in will be available soon',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final Color surfaceColor;
  final Color borderColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.textColor,
    required this.surfaceColor,
    required this.borderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        backgroundColor: surfaceColor,
        side: BorderSide(
          color: borderColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

