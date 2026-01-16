import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/selector_button.dart';
import 'widgets/phone_input_field.dart';
import 'widgets/social_login_section.dart';
import 'widgets/terms_checkbox.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String? _selectedCountry;
  String? _selectedState;
  bool _termsAgreed = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleCreateAccount() {
    if (_formKey.currentState!.validate()) {
      if (!_termsAgreed) {
        Get.snackbar(
          'Terms Required',
          'Please agree to the Terms of Service and Privacy Policy',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.error.withValues(alpha: 0.1),
          colorText: AppColors.error,
        );
        return;
      }

      // TODO: Implement signup logic
      Get.snackbar(
        'Success',
        'Account creation will be implemented soon',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success.withValues(alpha: 0.1),
        colorText: AppColors.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),

                // Header
                Text(
                  'signup_title'.tr,
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimaryLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),

                Text(
                  'signup_subtitle'.tr,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondaryLight,
                  ),
                ),
                const SizedBox(height: 32),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Full Name Field
                      CustomTextField(
                        controller: _fullNameController,
                        label: 'full_name'.tr,
                        placeholder: 'full_name_placeholder'.tr,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'error_full_name_required'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Email Field
                      CustomTextField(
                        controller: _emailController,
                        label: 'email_address'.tr,
                        placeholder: 'email_placeholder'.tr,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'error_email_required'.tr;
                          }
                          if (!GetUtils.isEmail(value)) {
                            return 'error_email_invalid'.tr;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Phone Number Field
                      PhoneInputField(
                        controller: _phoneController,
                        label: 'phone_number'.tr,
                        placeholder: 'phone_placeholder'.tr,
                      ),
                      const SizedBox(height: 20),

                      // Country Selector
                      SelectorButton(
                        label: _selectedCountry ?? 'select_country'.tr,
                        leadingIcon: Icons.public,
                        onTap: () {
                          // TODO: Show country picker
                          Get.snackbar(
                            'Coming Soon',
                            'Country selector will be available soon',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // State/Region Selector
                      SelectorButton(
                        label: _selectedState ?? 'select_state'.tr,
                        leadingIcon: Icons.location_on,
                        onTap: () {
                          // TODO: Show state picker
                          Get.snackbar(
                            'Coming Soon',
                            'State selector will be available soon',
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                      const SizedBox(height: 24),

                      // Terms Checkbox
                      TermsCheckbox(
                        value: _termsAgreed,
                        onChanged: (value) {
                          setState(() {
                            _termsAgreed = value ?? false;
                          });
                        },
                      ),
                      const SizedBox(height: 32),

                      // Create Account Button
                      PrimaryButton(
                        onPressed: _handleCreateAccount,
                        label: 'create_account'.tr,
                        suffixIcon: Icons.arrow_forward,
                        borderRadius: 30,
                        elevation: 8,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Social Login Section
                const SocialLoginSection(),
                const SizedBox(height: 32),

                // Already have account
                Center(
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondaryLight,
                      ),
                      children: [
                        TextSpan(text: 'already_have_account_login'.tr),
                        const TextSpan(text: ' '),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () {
                              // TODO: Navigate to login screen
                              Get.snackbar(
                                'Coming Soon',
                                'Login screen will be available soon',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Text(
                              'log_in'.tr,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

