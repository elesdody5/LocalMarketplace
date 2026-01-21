import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:presentation/widgets/search_dialog.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class DropdownWithSearchDialog extends StatefulWidget {
  final List<String> items;
  final String name;
  final String hint;
  final String errorMessage;
  final bool? enabled;
  final TextEditingController? controller;
  final bool required;
  final String? initialValue;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final InputDecoration? decoration;
  final Function(String)? onAddSuggestion;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double borderRadius;
  final double borderWidth;
  final TextStyle? textStyle;
  final double? iconSize;
  final IconData? prefixIcon;
  final Color? prefixIconColor;

  const DropdownWithSearchDialog({
    super.key,
    required this.name,
    required this.items,
    required this.hint,
    this.controller,
    this.enabled,
    this.onAddSuggestion,
    required this.required,
    required this.errorMessage,
    this.initialValue,
    this.onChanged,
    this.onSaved,
    this.decoration,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.textStyle,
    this.iconSize = 20,
    this.prefixIcon,
    this.prefixIconColor,
  });

  @override
  State<DropdownWithSearchDialog> createState() =>
      _DropdownWithSearchDialogState();
}

class _DropdownWithSearchDialogState extends State<DropdownWithSearchDialog> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      controller.text = widget.initialValue!;
    }
  }

  @override
  void didUpdateWidget(DropdownWithSearchDialog oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialValue != oldWidget.initialValue) {
        if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
          controller.text = widget.initialValue!;
        } else {
          controller.text = "";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final effectiveBackgroundColor = widget.backgroundColor ??
        (isDark ? AppColors.surfaceDark : AppColors.surfaceLight);
    final effectiveBorderColor = widget.borderColor ?? AppColors.primaryColor;
    final effectiveTextColor = widget.textColor ??
        (isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight);
    final effectiveIconColor = widget.iconColor ?? AppColors.primaryColor;
    final effectivePrefixIconColor = widget.prefixIconColor ?? AppColors.primaryColor;
    final hintColor = effectiveTextColor.withValues(alpha: 0.6);

    return FormBuilderTextField(
      name: widget.name,
      controller: controller,
      readOnly: true,
      style: widget.textStyle ??
          AppTextStyles.bodyMedium.copyWith(
            color: effectiveTextColor,
            fontWeight: FontWeight.w500,
          ),
      onSaved: (_) {
        if (controller.text.isNotEmpty) widget.onSaved?.call(controller.text);
      },
      validator: FormBuilderValidators.compose([
        (_) {
          if (widget.required &&
              (controller.text.isEmpty ||
                  !widget.items.contains(controller.text))) {
            return widget.errorMessage;
          }
          return null;
        },
      ]),
      decoration: widget.decoration ??
          InputDecoration(
            hintText: widget.hint,
            hintStyle: widget.textStyle ??
                AppTextStyles.bodyMedium.copyWith(
                  color: hintColor,
                  fontWeight: FontWeight.w500,
                ),
            filled: true,
            fillColor: effectiveBackgroundColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: effectivePrefixIconColor,
                    size: widget.iconSize,
                  )
                : null,
            suffixIcon: Icon(
              Icons.keyboard_arrow_down,
              color: effectiveIconColor,
              size: widget.iconSize,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: effectiveBorderColor,
                width: widget.borderWidth,
              ),
            ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(widget.borderRadius),
            //   borderSide: BorderSide(
            //     color: effectiveBorderColor,
            //     width: widget.borderWidth * 2,
            //   ),
            // ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: AppColors.error,
                width: widget.borderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: AppColors.error,
                width: widget.borderWidth * 2,
              ),
            ),
          ),
      onTap: () async {
        if (widget.enabled == false) return;
        var result = await Get.dialog(SearchDialog(
          title: widget.hint,
          placeHolder: widget.hint,
          items: widget.items,
          onAddSuggestion: widget.onAddSuggestion,
        ));
        if (result != null) {
          setState(() {
            controller.text = result;
            widget.onChanged?.call(result);
          });
        }
      },
    );
  }
}
