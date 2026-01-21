import 'package:flutter/material.dart';
import 'package:presentation/theme/app_colors.dart';

class OnboardingPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const OnboardingPageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Pre-calculate inactive color for performance
    final inactiveColor = isDark
        ? const Color(0xFF374151)
        : const Color(0xFFcfdbe6);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => _buildIndicator(index, inactiveColor),
      ),
    );
  }

  Widget _buildIndicator(int index, Color inactiveColor) {
    final isActive = index == currentPage;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 10,
      width: isActive ? 32 : 10,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : inactiveColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

