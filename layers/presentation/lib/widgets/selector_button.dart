import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class SelectorButton extends StatelessWidget {
  final String label;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final VoidCallback onTap;
  final bool enabled;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final double? leadingIconSize;
  final double? trailingIconSize;
  final Widget? customLeading;
  final Widget? customTrailing;

  const SelectorButton({
    super.key,
    required this.label,
    required this.onTap,
    this.leadingIcon,
    this.trailingIcon = Icons.arrow_forward_ios,
    this.enabled = true,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    this.textStyle,
    this.leadingIconSize = 20,
    this.trailingIconSize = 16,
    this.customLeading,
    this.customTrailing,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveBackgroundColor = backgroundColor ??
        (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final effectiveBorderColor = borderColor ??
        (isDark ? AppColors.dividerDark : AppColors.dividerLight);
    final effectiveTextColor = textColor ??
        (isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight);
    final effectiveIconColor = iconColor ?? effectiveTextColor;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: effectiveBorderColor,
            width: borderWidth,
          ),
        ),
        child: Row(
          children: [
            if (customLeading != null)
              customLeading!
            else if (leadingIcon != null) ...[
              Icon(
                leadingIcon,
                color: effectiveIconColor,
                size: leadingIconSize,
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                label,
                style: textStyle ??
                    AppTextStyles.bodyMedium.copyWith(
                      color: effectiveTextColor,
                    ),
              ),
            ),
            if (customTrailing != null)
              customTrailing!
            else if (trailingIcon != null)
              Icon(
                trailingIcon,
                color: effectiveIconColor,
                size: trailingIconSize,
              ),
          ],
        ),
      ),
    );
  }
}
