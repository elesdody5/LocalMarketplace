import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pinput/pinput.dart';
import 'package:presentation/auth/verification/verification_controller.dart';
import 'package:presentation/auth/verification/state/verification_actions.dart';

/// Code input form using Pinput widget
/// Provides 6-digit PIN input with custom styling
class CodeInputForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final VerificationController controller;
  final Color primaryColor;
  final bool isDark;
  final ColorScheme colorScheme;

  const CodeInputForm({
    super.key,
    required this.formKey,
    required this.controller,
    required this.primaryColor,
    required this.isDark,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    // Define pin themes matching HTML design
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade800 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.grey.shade700
                : Colors.grey.shade200,
            blurRadius: 0,
            spreadRadius: 1,
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: primaryColor,
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: primaryColor.withValues(alpha: 0.2),
          blurRadius: 0,
          spreadRadius: 1,
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: isDark
            ? Colors.grey.shade700
            : Colors.grey.shade50,
      ),
    );

    return FormBuilder(
      key: formKey,
      child: Center(
        child: Pinput(
          length: 6,
          controller: TextEditingController(text: controller.state.code),
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: focusedPinTheme,
          submittedPinTheme: submittedPinTheme,
          autofocus: true,
          showCursor: true,
          cursor: Container(
            width: 2,
            height: 24,
            color: primaryColor,
          ),
          keyboardType: TextInputType.number,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 200),
          onChanged: (value) {
            controller.verificationAction(UpdateCode(value));
          },
          onCompleted: (value) {
            controller.verificationAction(UpdateCode(value));
          },
        ),
      ),
    );
  }
}
