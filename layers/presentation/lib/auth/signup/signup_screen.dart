import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/theme/app_text_styles.dart';
import 'package:presentation/widgets/custom_text_field.dart';
import 'package:presentation/widgets/primary_button.dart' show PrimaryButton;
import 'package:presentation/widgets/selector_button.dart';

import 'signup_controller.dart';
import 'state/signup_actions.dart';
import 'widgets/phone_input_field.dart';
import 'widgets/social_login_section.dart';
import 'widgets/terms_checkbox.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  void saveAndValidate(void Function() createAccount) {
    // Validate and save the form values
    if (_formKey.currentState?.saveAndValidate() == true) createAccount();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GetBuilder<SignupController>(
      init: GetIt.I<SignupController>(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: isDark
              ? AppColors.backgroundDark
              : AppColors.backgroundLight,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
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
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Full Name Field
                          CustomTextField(
                            name: 'full_name',
                            label: 'full_name'.tr,
                            placeholder: 'full_name_placeholder'.tr,
                            onSaved: (name) => controller.signupAction(
                              SaveUserData(
                                controller.state.user.copyWith(name: name),
                              ),
                            ),
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
                            name: 'email',
                            label: 'email_address'.tr,
                            placeholder: 'email_placeholder'.tr,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (email) => controller.signupAction(
                              SaveUserData(
                                controller.state.user.copyWith(email: email),
                              ),
                            ),
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
                            name: 'phone',
                            label: 'phone_number'.tr,
                            placeholder: 'phone_placeholder'.tr,
                            onSaved: (phone) => controller.signupAction(
                              SaveUserData(
                                controller.state.user.copyWith(
                                  phoneNumber: phone,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Country Selector
                          SelectorButton(
                            label:
                                controller.selectedCountry ??
                                'select_country'.tr,
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
                            label:
                                controller.selectedState ?? 'select_state'.tr,
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
                            value: controller.termsAgreed,
                            onChanged: (value) {
                              controller.setTermsAgreed(value ?? false);
                            },
                          ),
                          const SizedBox(height: 32),

                          // Create Account Button
                          PrimaryButton(
                            onPressed: () => saveAndValidate(
                              () => controller.signupAction(Signup()),
                            ),
                            isLoading: controller.state.isLoading,
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
      },
    );
  }
}
