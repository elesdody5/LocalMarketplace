import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Secure badge widget displayed in the AppBar
/// Shows a lock icon with "SECURE" text in a rounded container
class SecureBadge extends StatelessWidget {
  final Color primaryColor;
  final bool isDark;

  const SecureBadge({
    super.key,
    required this.primaryColor,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final badgeBackground = isDark
        ? Colors.cyan.shade900.withValues(alpha: 0.2)
        : Colors.lightBlue.shade100.withValues(alpha: 0.5);
    final badgeBorder = isDark
        ? Colors.cyan.shade800.withValues(alpha: 0.3)
        : Colors.lightBlue.shade200.withValues(alpha: 0.5);
    final badgeTextColor = isDark ? Colors.cyan.shade400 : primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: badgeBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.lock,
            size: 16,
            color: badgeTextColor,
          ),
          const SizedBox(width: 6),
          Text(
            'secure_badge'.tr.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: badgeTextColor,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
