import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/login/login_controller.dart';
import 'package:presentation/auth/login/state/login_actions.dart';
import 'package:presentation/auth/signup/widgets/password_input_field.dart';
import 'package:presentation/widgets/custom_text_field.dart';
import 'package:presentation/widgets/primary_button.dart';

/// Login form widget containing email/phone, password fields and login button
class LoginForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final LoginController controller;
  final VoidCallback onLogin;
  final Color primaryColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onLogin,
    required this.primaryColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email or Phone Field
          CustomTextField(
            name: 'email_or_phone',
            label: 'email_or_phone'.tr,
            placeholder: 'email_or_phone_placeholder'.tr,
            keyboardType: TextInputType.emailAddress,
            suffixIcon: Icon(
              Icons.person,
              color: primaryColor,
            ),
            onSaved: (value) => controller.loginAction(
              SaveLoginCredentials(emailOrPhone: value),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'error_email_or_phone_required'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Password Field
          PasswordInputField(
            name: 'password',
            label: 'password'.tr,
            placeholder: 'password_placeholder'.tr,
            onSaved: (value) => controller.loginAction(
              SaveLoginCredentials(password: value),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'error_email_or_phone_required'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 8),

          // Forgot Password Link
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Get.snackbar(
                  'Coming Soon',
                  'Forgot password feature will be available soon',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'forgot_password'.tr,
                style: textTheme.bodySmall?.copyWith(
                  color: onSurfaceMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Login Button
          PrimaryButton(
            onPressed: onLogin,
            isLoading: controller.state.isLoading,
            label: 'login_button'.tr,
            borderRadius: 30,
            elevation: 8,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ],
      ),
    );
  }
}
