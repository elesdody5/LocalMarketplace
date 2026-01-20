import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:presentation/theme/app_colors.dart';
import 'package:presentation/theme/app_text_styles.dart';


class PhoneInputField extends StatelessWidget {
  final String name;
  final String label;
  final String placeholder;
  final ValueChanged<String?>? onSaved;

  const PhoneInputField({
    super.key,
    required this.name,
    required this.label,
    required this.placeholder,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.labelLarge.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        FormBuilderTextField(
          name: name,
          keyboardType: TextInputType.phone,
          onSaved: onSaved,
          style: AppTextStyles.bodyLarge.copyWith(
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                widthFactor: 1,
                child: Icon(
                  Icons.phone_android_outlined,
                  color: AppColors.primaryColor
                ),
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'error_phone_required'.tr;
            }
            return null;
          },
        ),
      ],
    );
  }
}

