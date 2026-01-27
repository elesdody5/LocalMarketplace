import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/theme/app_text_styles.dart';

/// Password Input Field Widget
/// A secure password field with show/hide toggle functionality
/// Matches the app's design system with primary color borders
class PasswordInputField extends StatefulWidget {
  final String name;
  final String label;
  final String placeholder;
  final String? Function(String?)? validator;
  final ValueChanged<String?>? onSaved;
  final ValueChanged<String?>? onChanged;
  final TextEditingController? controller;
  final String? initialValue;
  final bool enabled;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;

  const PasswordInputField({
    super.key,
    required this.name,
    required this.label,
    required this.placeholder,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.initialValue,
    this.enabled = true,
    this.focusNode,
    this.autovalidateMode,
  });

  @override
  State<PasswordInputField> createState() => _PasswordInputFieldState();
}

class _PasswordInputFieldState extends State<PasswordInputField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final textPrimaryColor = isDark
        ? AppColors.textPrimaryDark
        : AppColors.textPrimaryLight;
    final textSecondaryColor = isDark
        ? AppColors.textSecondaryDark
        : AppColors.textSecondaryLight;
    final surfaceColor = isDark
        ? AppColors.surfaceDark
        : AppColors.surfaceLight;
    final hintColor = textSecondaryColor.withValues(alpha: 0.6);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.labelLarge.copyWith(
            color: textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        FormBuilderTextField(
          name: widget.name,
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          obscureText: _obscureText,
          enabled: widget.enabled,
          focusNode: widget.focusNode,
          autovalidateMode: widget.autovalidateMode,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          validator: widget.validator,
          style: AppTextStyles.bodyLarge.copyWith(
            color: textPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: AppTextStyles.bodyLarge.copyWith(
              color: hintColor,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: surfaceColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: AppColors.primaryColor,
              size: 20,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.primaryColor,
                size: 20,
              ),
              onPressed: _togglePasswordVisibility,
            ),
            errorMaxLines: 3,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.error, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
