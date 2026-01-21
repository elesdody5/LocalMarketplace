import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/routes/routes.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'widgets/language_toggle.dart';
import 'widgets/social_login_button.dart';
import 'widgets/welcome_hero_section.dart';
import 'widgets/welcome_image_card.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final textPrimaryColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondaryColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final primaryShadow = AppColors.primaryColor.withValues(alpha: 0.4);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // Remove back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.storefront,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'app_name'.tr,
              style: AppTextStyles.titleLarge.copyWith(
                color: textPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: const [LanguageToggle(), SizedBox(width: 16)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // Single Image Card (no carousel)
                const WelcomeImageCard(),
                const SizedBox(height: 24),

                // Hero Title and Description
                const WelcomeHeroSection(),
                const SizedBox(height: 32),

                // Main Title
                Text(
                  'welcome_title'.tr,
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: textPrimaryColor,
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                // Subtitle
                Text(
                  'welcome_subtitle'.tr,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Get Started Button
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(signupRouteName);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 8,
                    shadowColor: primaryShadow,
                  ),
                  child: Text(
                    'get_started_button'.tr,
                    style: AppTextStyles.labelLarge.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Social Login Buttons
                Row(
                  children: [
                    Expanded(
                      child: SocialLoginButton(
                        label: 'google_button'.tr,
                        icon: const Icon(
                          Icons.g_mobiledata,
                          color: Color(0xFFDB4437),
                        ),
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
                      child: SocialLoginButton(
                        label: 'facebook_button'.tr,
                        icon: const Icon(
                          Icons.facebook,
                          color: Color(0xFF1877F2),
                          size: 24,
                        ),
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
                const SizedBox(height: 16),

                // Already have account link
                TextButton(
                  onPressed: () {
                    Get.toNamed(loginRouteName);
                  },
                  child: Text(
                    'already_have_account'.tr,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: textSecondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Terms and Privacy
                Text(
                  'terms_privacy'.tr,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: textSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
