import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation/widgets/primary_button.dart';

class OnboardingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLastPage;

  const OnboardingActionButton({
    super.key,
    required this.onPressed,
    required this.isLastPage,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        label: isLastPage ? 'get_started'.tr : 'next'.tr,
        suffixIcon: isLastPage ? Icons.arrow_forward : null,
        onPressed: onPressed,
      ),
    );
  }
}
