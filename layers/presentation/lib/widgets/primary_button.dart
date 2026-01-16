import 'package:flutter/material.dart';
import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/theme/app_text_styles.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double iconSize;
  final double iconSpacing;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.prefixIcon,
    this.suffixIcon,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.borderRadius = 12,
    this.elevation = 4,
    this.backgroundColor,
    this.foregroundColor,
    this.textStyle,
    this.fontSize = 18,
    this.fontWeight = FontWeight.w700,
    this.iconSize = 20,
    this.iconSpacing = 12,
  });

  bool get _effectiveDisabled => isDisabled || onPressed == null || isLoading;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ?? AppColors.primaryColor;
    final effectiveForegroundColor = foregroundColor ?? Colors.white;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _effectiveDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: effectiveBackgroundColor,
          foregroundColor: effectiveForegroundColor,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: elevation,
          shadowColor: effectiveBackgroundColor.withValues(alpha: 0.4),
        ),
        child: _buildChild(effectiveForegroundColor),
      ),
    );
  }

  Widget _buildChild(Color effectiveForegroundColor) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: effectiveForegroundColor,
        ),
      );
    }

    // If no icons, just show text
    if (prefixIcon == null && suffixIcon == null) {
      return Text(
        label,
        style: textStyle ??
            AppTextStyles.labelLarge.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
      );
    }

    // Show text with icons
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefixIcon != null) ...[
          Icon(prefixIcon, size: iconSize),
          SizedBox(width: iconSpacing),
        ],
        Text(
          label,
          style: textStyle ??
              AppTextStyles.labelLarge.copyWith(
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
        ),
        if (suffixIcon != null) ...[
          SizedBox(width: iconSpacing),
          Icon(suffixIcon, size: iconSize),
        ],
      ],
    );
  }
}
