import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingContent extends StatelessWidget {
  final String titleKey;
  final String descriptionKey;

  const OnboardingContent({
    super.key,
    required this.titleKey,
    required this.descriptionKey,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Text(
          titleKey.tr,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: isDark ? Colors.white : const Color(0xFF0f172a),
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Description
        Text(
          descriptionKey.tr,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark
                ? const Color(0xFFD1D5DB)
                : const Color(0xFF0f172a).withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
          maxLines: 3,
        ),
      ],
    );
  }
}

