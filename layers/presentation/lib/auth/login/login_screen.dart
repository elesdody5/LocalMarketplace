import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/auth/login/login_state_handler.dart' as login_handler;
import 'package:presentation/routes/routes.dart';
import 'package:presentation/widgets/custom_text_field.dart';
import 'package:presentation/widgets/primary_button.dart';

import 'login_controller.dart';
import 'state/login_actions.dart';
import '../signup/widgets/password_input_field.dart';
import '../signup/widgets/social_login_section.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  void saveAndValidate(void Function() login) {
    // Validate and save the form values
    if (_formKey.currentState?.saveAndValidate() == true) login();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Get.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = Get.textTheme;

    // Pre-calculate alpha colors for performance
    final primaryShadow = colorScheme.primary.withValues(alpha: 0.2);
    final onSurfaceMuted = colorScheme.onSurface.withValues(alpha: 0.6);
    final surfaceTranslucent = colorScheme.surface.withValues(alpha: 0.95);
    final borderColor = colorScheme.onSurface.withValues(alpha: 0.1);

    final controller = Get.put(GetIt.I<LoginController>());
    login_handler.observeLoginEvents(controller.event);

    return GetBuilder<LoginController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorScheme.onSurface,
              ),
              onPressed: () => Get.back(),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Main scrollable content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 24),
                          _LoginHeader(
                            primaryColor: colorScheme.primary,
                            primaryShadow: primaryShadow,
                            onSurfaceColor: colorScheme.onSurface,
                            onSurfaceMuted: onSurfaceMuted,
                            textTheme: textTheme,
                          ),
                          const SizedBox(height: 32),

                          // Form
                          _LoginForm(
                            formKey: _formKey,
                            controller: controller,
                            onLogin: () => saveAndValidate(
                              () => controller.loginAction(Login()),
                            ),
                            primaryColor: colorScheme.primary,
                            onSurfaceMuted: onSurfaceMuted,
                            textTheme: textTheme,
                          ),

                          const SizedBox(height: 32),

                          // Social Login Section
                          const SocialLoginSection(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom sticky section - Optimized
                _BottomSignupSection(
                  surfaceTranslucent: surfaceTranslucent,
                  borderColor: borderColor,
                  onSurfaceMuted: onSurfaceMuted,
                  primaryColor: colorScheme.primary,
                  textTheme: textTheme,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ✅ Extract header to const widget to prevent rebuilds
class _LoginHeader extends StatelessWidget {
  final Color primaryColor;
  final Color primaryShadow;
  final Color onSurfaceColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const _LoginHeader({
    required this.primaryColor,
    required this.primaryShadow,
    required this.onSurfaceColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // ✅ Wrap Transform.rotate in RepaintBoundary
          RepaintBoundary(
            child: Transform.rotate(
              angle: 0.05236, // 3 degrees in radians
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryShadow,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.storefront,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'welcome_back_title'.tr,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: onSurfaceColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            'welcome_back_subtitle'.tr,
            style: textTheme.bodyMedium?.copyWith(
              color: onSurfaceMuted,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

// ✅ Extract form to separate widget
class _LoginForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final LoginController controller;
  final VoidCallback onLogin;
  final Color primaryColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const _LoginForm({
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

// ✅ Extract bottom section to const widget
class _BottomSignupSection extends StatelessWidget {
  final Color surfaceTranslucent;
  final Color borderColor;
  final Color onSurfaceMuted;
  final Color primaryColor;
  final TextTheme textTheme;

  const _BottomSignupSection({
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
