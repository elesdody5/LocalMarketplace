import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:presentation/auth/reset_password/reset_password_controller.dart';
import 'package:presentation/auth/reset_password/state/reset_password_actions.dart';
import 'package:presentation/theme/app_text_styles.dart';
import 'package:presentation/widgets/primary_button.dart';

class ResetPasswordForm extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final ResetPasswordController controller;
  final VoidCallback onSubmit;
  final Color primaryColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const ResetPasswordForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.onSubmit,
    required this.primaryColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilderTextField(
            name: 'newPassword',
            obscureText: !_newPasswordVisible,
            textInputAction: TextInputAction.next,
            onSaved: (value) => widget.controller.resetPasswordAction(
              SaveNewPassword(value ?? ''),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'error_password_invalid'.tr;
              }
              // Check all validation rules
              final hasMinLength = value.length >= 8;
              final hasLowercase = value.contains(RegExp(r'[a-z]'));
              final hasUppercase = value.contains(RegExp(r'[A-Z]'));
              final hasDigit = value.contains(RegExp(r'[0-9]'));

              if (!hasMinLength ||
                  !hasLowercase ||
                  !hasUppercase ||
                  !hasDigit) {
                return 'error_password_invalid'.tr;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'new_password'.tr,
              prefixIcon: Icon(Icons.lock, color: widget.primaryColor),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _newPasswordVisible = !_newPasswordVisible;
                }),
                icon: Icon(
                  _newPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'confirmPassword',
            obscureText: !_confirmPasswordVisible,
            textInputAction: TextInputAction.done,
            onSaved: (value) => widget.controller.resetPasswordAction(
              SaveConfirmPassword(value ?? ''),
            ),
            validator: (value) {
              final v = value ?? '';
              if (v.isEmpty) return 'error_required'.tr;
              final newPassword =
                  widget.formKey.currentState?.fields['newPassword']?.value
                      as String? ??
                  '';
              if (newPassword.isNotEmpty && v != newPassword) {
                return 'error_passwords_do_not_match'.tr;
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'confirm_new_password'.tr,
              prefixIcon: Icon(Icons.lock, color: widget.primaryColor),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                }),
                icon: Icon(
                  _confirmPasswordVisible
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          GetBuilder<ResetPasswordController>(
            builder: (controller) {
              return PrimaryButton(
                onPressed: widget.onSubmit,
                isLoading: controller.state.isLoading,
                label: 'update_password'.tr,
                borderRadius: 12,
                elevation: 8,
                padding: const EdgeInsets.symmetric(vertical: 16),
              );
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () {
                Get.snackbar(
                  'Coming Soon',
                  'Contact support feature will be available soon',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: RichText(
                text: TextSpan(
                  text: '${'need_more_help'.tr} ',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: widget.onSurfaceMuted,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: 'contact_support'.tr,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: widget.onSurfaceMuted,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
