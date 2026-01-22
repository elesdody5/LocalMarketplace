import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/auth/signup/signup_state_handler.dart';
import 'package:presentation/routes/auth_routes.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/theme/app_text_styles.dart';
import 'package:presentation/widgets/custom_text_field.dart';
import 'package:presentation/widgets/drop_down_with_search.dart';
import 'package:presentation/widgets/primary_button.dart' show PrimaryButton;

import 'signup_controller.dart';
import 'state/signup_actions.dart';
import 'widgets/password_input_field.dart';
import 'widgets/phone_input_field.dart';
import 'widgets/profile_picture_picker.dart';
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
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final backgroundColor = isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    final textPrimaryColor = isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final textSecondaryColor = isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final controller = Get.put(GetIt.I<SignupController>());
    observeSignupEvents(controller.event);

    return GetBuilder<SignupController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: textPrimaryColor,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                        color: textPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),

                    Text(
                      'signup_subtitle'.tr,
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: textSecondaryColor,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Form
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Profile Picture Picker
                          ProfilePicturePicker(
                            name: 'profile_picture',
                            onChanged: (image) {
                              // TODO: Handle profile picture change
                              debugPrint(
                                'Profile picture selected: ${image?.path}',
                              );
                            },
                            onSaved: (image) {
                              // TODO: Save profile picture
                              debugPrint(
                                'Profile picture saved: ${image?.path}',
                              );
                            },
                          ),
                          const SizedBox(height: 24),

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

                          // Password Field
                          PasswordInputField(
                            name: 'password',
                            label: 'password'.tr,
                            placeholder: 'password_placeholder'.tr,
                            onSaved: (password) => password != null
                                ? controller.signupAction(
                                    UpdatePassword(password),
                                  )
                                : null,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'error_password_invalid'.tr;
                              }
                              // Check all validation rules
                              final hasMinLength = value.length >= 8;
                              final hasLowercase = value.contains(
                                RegExp(r'[a-z]'),
                              );
                              final hasUppercase = value.contains(
                                RegExp(r'[A-Z]'),
                              );
                              final hasDigit = value.contains(RegExp(r'[0-9]'));

                              if (!hasMinLength ||
                                  !hasLowercase ||
                                  !hasUppercase ||
                                  !hasDigit) {
                                return 'error_password_invalid'.tr;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Confirm Password Field
                          PasswordInputField(
                            name: 'confirm_password',
                            label: 'confirm_password'.tr,
                            placeholder: 'confirm_password_placeholder'.tr,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'error_confirm_password_required'.tr;
                              }
                              final password = _formKey
                                  .currentState
                                  ?.fields['password']
                                  ?.value;
                              if (value != password) {
                                return 'error_passwords_dont_match'.tr;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Country Selector
                          DropdownWithSearchDialog(
                            name: 'country',
                            items: controller.countries,
                            hint: 'select_country'.tr,
                            required: true,
                            errorMessage: 'error_country_required'.tr,
                            initialValue: controller.selectedCountry,
                            prefixIcon: Icons.public,
                            onChanged: (value) {
                              controller.setSelectedCountry(value);
                            },
                            onSaved: (value) {
                              controller.setSelectedCountry(value);
                            },
                          ),
                          const SizedBox(height: 20),

                          // State/Region Selector
                          DropdownWithSearchDialog(
                            name: 'state',
                            items: controller.states,
                            hint: 'select_state'.tr,
                            required: true,
                            errorMessage: 'error_state_required'.tr,
                            initialValue: controller.selectedState,
                            prefixIcon: Icons.location_on,
                            onChanged: (value) {
                              controller.setSelectedState(value);
                            },
                            onSaved: (value) {
                              controller.setSelectedState(value);
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

                    // Already have account - ✅ Replace RichText with Row
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'already_have_account_login'.tr,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: textSecondaryColor,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              // Navigate to login screen using offNamed to replace route
                              Get.offNamed(loginRouteName);
                            },
                            child: Text(
                              'log_in'.tr,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
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
