import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/auth/login/login_state_handler.dart' as login_handler;
import 'package:presentation/auth/login/widgets/bottom_signup_section.dart';
import 'package:presentation/auth/login/widgets/login_form.dart';
import 'package:presentation/auth/login/widgets/login_header.dart';

import 'login_controller.dart';
import 'state/login_actions.dart';
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
                          LoginHeader(
                            primaryColor: colorScheme.primary,
                            primaryShadow: primaryShadow,
                            onSurfaceColor: colorScheme.onSurface,
                            onSurfaceMuted: onSurfaceMuted,
                            textTheme: textTheme,
                          ),
                          const SizedBox(height: 32),

                          // Form
                          LoginForm(
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
                BottomSignupSection(
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

