import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? placeholder;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final String? initialValue;
  final AutovalidateMode? autovalidateMode;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final double borderWidth;
  final double focusedBorderWidth;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.placeholder,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.initialValue,
    this.autovalidateMode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.borderRadius = 12,
    this.contentPadding,
    this.fillColor,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.borderWidth = 1,
    this.focusedBorderWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: labelStyle ??
                AppTextStyles.labelMedium.copyWith(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimaryLight,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          validator: validator,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          focusNode: focusNode,
          autovalidateMode: autovalidateMode,
          style: textStyle ??
              AppTextStyles.bodyMedium.copyWith(
                color: isDark
                    ? AppColors.textPrimaryDark
                    : AppColors.textPrimaryLight,
              ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: hintStyle ??
                AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondaryLight,
                ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: fillColor ??
                (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: enabledBorderColor ??
                    (isDark ? AppColors.dividerDark : AppColors.dividerLight),
                width: borderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: enabledBorderColor ??
                    (isDark ? AppColors.dividerDark : AppColors.dividerLight),
                width: borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: focusedBorderColor ?? AppColors.primaryColor,
                width: focusedBorderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorBorderColor ?? AppColors.error,
                width: borderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: errorBorderColor ?? AppColors.error,
                width: focusedBorderWidth,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: isDark
                    ? AppColors.dividerDark.withValues(alpha: 0.5)
                    : AppColors.dividerLight.withValues(alpha: 0.5),
                width: borderWidth,
              ),
            ),
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
            counterText: maxLength != null ? null : '',
          ),
        ),
      ],
    );
  }
}
