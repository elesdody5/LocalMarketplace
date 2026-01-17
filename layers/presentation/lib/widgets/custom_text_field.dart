import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String name;
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
  final ValueChanged<String?>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSaved;
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
    required this.name,
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
    this.onSaved,
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
        FormBuilderTextField(
          name: name,
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onSaved: onSaved,
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
            hintStyle: hintStyle,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            fillColor: fillColor,
            contentPadding: contentPadding,
            counterText: maxLength != null ? null : '',
            border: _buildBorder(enabledBorderColor, borderWidth, borderRadius),
            enabledBorder: _buildBorder(enabledBorderColor, borderWidth, borderRadius),
            // focusedBorder: _buildBorder(focusedBorderColor, focusedBorderWidth, borderRadius),
            errorBorder: _buildBorder(errorBorderColor, borderWidth, borderRadius),
            // focusedErrorBorder: _buildBorder(errorBorderColor, focusedBorderWidth, borderRadius),
          ).applyDefaults(Theme.of(context).inputDecorationTheme),
        ),
      ],
    );
  }

  OutlineInputBorder? _buildBorder(Color? color, double width, double radius) {
    if (color == null && width == 1 && radius == 12) return null;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: width,
      ),
    );
  }
}
