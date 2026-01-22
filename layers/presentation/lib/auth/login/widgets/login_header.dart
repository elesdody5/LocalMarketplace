import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Login screen header widget
/// Displays app icon, welcome title, and subtitle
class LoginHeader extends StatelessWidget {
  final Color primaryColor;
  final Color primaryShadow;
  final Color onSurfaceColor;
  final Color onSurfaceMuted;
  final TextTheme textTheme;

  const LoginHeader({
    super.key,
    required this.primaryColor,
    required this.primaryShadow,
    required this.onSurfaceColor,
    required this.onSurfaceMuted,
    required this.textTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // ✅ Wrap Transform.rotate in RepaintBoundary
          RepaintBoundary(
            child: Transform.rotate(
              angle: 0.05236, // 3 degrees in radians
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: primaryShadow,
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.storefront,
                  size: 36,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'welcome_back_title'.tr,
            style: textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: onSurfaceColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Subtitle
          Text(
            'welcome_back_subtitle'.tr,
            style: textTheme.bodyMedium?.copyWith(
              color: onSurfaceMuted,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
