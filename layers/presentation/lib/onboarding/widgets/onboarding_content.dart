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
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate colors for performance
    final titleColor = isDark ? Colors.white : const Color(0xFF0f172a);
    final descriptionColor = isDark
        ? const Color(0xFFD1D5DB)
        : const Color(0xFF0f172a).withValues(alpha: 0.8);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title
        Text(
          titleKey.tr,
          style: textTheme.headlineLarge?.copyWith(
            color: titleColor,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),

        // Description
        Text(
          descriptionKey.tr,
          style: textTheme.bodyLarge?.copyWith(
            color: descriptionColor,
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

