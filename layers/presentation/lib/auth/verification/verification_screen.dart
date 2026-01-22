import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:presentation/auth/verification/verification_state_handler.dart' as verification_handler;
import 'package:presentation/auth/verification/widgets/bottom_email_section.dart';
import 'package:presentation/auth/verification/widgets/code_input_form.dart';
import 'package:presentation/auth/verification/widgets/resend_section.dart';
import 'package:presentation/auth/verification/widgets/secure_badge.dart';
import 'package:presentation/auth/verification/widgets/verification_header.dart';
import 'package:presentation/auth/verification/widgets/verify_button.dart';

import 'verification_controller.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Get.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = Get.textTheme;

    // Pre-calculate colors for performance
    final primaryColor = colorScheme.primary;
    final primaryShadow = colorScheme.primary.withValues(alpha: 0.2);
    final onSurfaceMuted = colorScheme.onSurface.withValues(alpha: 0.6);
    final surfaceTranslucent = colorScheme.surface.withValues(alpha: 0.95);
    final borderColor = colorScheme.onSurface.withValues(alpha: 0.1);
    final isDark = Get.isDarkMode;

    final controller = Get.put(GetIt.I<VerificationController>());
    observeVerificationEvents(controller.event);

    return GetBuilder<VerificationController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: colorScheme.surface,
          bottomNavigationBar: BottomEmailSection(
            surfaceTranslucent: surfaceTranslucent,
            borderColor: borderColor,
            onSurfaceMuted: onSurfaceMuted,
            primaryColor: primaryColor,
            textTheme: textTheme,
          ),
          appBar: AppBar(
            backgroundColor: surfaceTranslucent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: colorScheme.onSurface,
              ),
              onPressed: () => Get.back(),
            ),
            centerTitle: true,
            title: SecureBadge(
              primaryColor: primaryColor,
              isDark: isDark,
            ),
            actions: const [SizedBox(width: 48)], // Balance the back button
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

                          // Header with SMS icon and title
                          VerificationHeader(
                            primaryColor: primaryColor,
                            primaryShadow: primaryShadow,
                            onSurfaceColor: colorScheme.onSurface,
                            onSurfaceMuted: onSurfaceMuted,
                            textTheme: textTheme,
                            maskedPhoneNumber: controller.state.maskedPhoneNumber,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 40),

                          // Code Input Form
                          CodeInputForm(
                            formKey: _formKey,
                            controller: controller,
                            primaryColor: primaryColor,
                            isDark: isDark,
                            colorScheme: colorScheme,
                          ),
                          const SizedBox(height: 32),

                          // Resend Section
                          ResendSection(
                            controller: controller,
                            onSurfaceMuted: onSurfaceMuted,
                            primaryColor: primaryColor,
                            textTheme: textTheme,
                            isDark: isDark,
                          ),
                          const SizedBox(height: 40),

                          // Verify Button
                          VerifyButton(
                            controller: controller,
                            primaryColor: primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}

