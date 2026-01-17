import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Error Snackbar Widget
/// Displays error messages with icon and styled appearance matching the app design
class ErrorSnackbar {
  ErrorSnackbar._();

  /// Show an error snackbar with the given message
  ///
  /// [message] - The error message to display
  /// [title] - Optional title for the snackbar (defaults to "Error")
  /// [duration] - How long to show the snackbar (defaults to 3 seconds)
  /// [icon] - Custom icon to display (defaults to wifi/connection icon)
  /// [backgroundColor] - Custom background color (defaults to dark red)
  static void show({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
    Color? backgroundColor,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : const SizedBox.shrink(),
      messageText: Row(
        children: [
          // Icon container with circular background
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.wifi_off,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          // Message text
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? const Color(0xFF991B1B),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderColor: const Color(0xFF7F1D1D),
      borderWidth: 1,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 2,
        ),
      ],
    );
  }

  /// Show a connection error snackbar
  static void showConnectionError({
    String? message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      message: message ?? 'Connection timeout. Please try again later.',
      icon: Icons.wifi_off,
      duration: duration,
    );
  }

  /// Show a validation error snackbar
  static void showValidationError({
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      message: message,
      icon: Icons.error_outline,
      duration: duration,
    );
  }

  /// Show a server error snackbar
  static void showServerError({
    String? message,
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      message: message ?? 'Something went wrong. Please try again.',
      icon: Icons.cloud_off,
      duration: duration,
    );
  }

  /// Show a generic error snackbar with custom icon
  static void showCustomError({
    required String message,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
  }) {
    show(
      message: message,
      icon: icon,
      duration: duration,
      backgroundColor: backgroundColor,
    );
  }
}

/// Success Snackbar Widget
/// Displays success messages with icon and styled appearance
class SuccessSnackbar {
  SuccessSnackbar._();

  /// Show a success snackbar with the given message
  static void show({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : const SizedBox.shrink(),
      messageText: Row(
        children: [
          // Icon container with circular background
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.check_circle_outline,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          // Message text
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.success,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderColor: const Color(0xFF388E3C),
      borderWidth: 1,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 2,
        ),
      ],
    );
  }
}

/// Warning Snackbar Widget
/// Displays warning messages with icon and styled appearance
class WarningSnackbar {
  WarningSnackbar._();

  /// Show a warning snackbar with the given message
  static void show({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : const SizedBox.shrink(),
      messageText: Row(
        children: [
          // Icon container with circular background
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.warning_amber_rounded,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          // Message text
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.warning,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderColor: const Color(0xFFF57C00),
      borderWidth: 1,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 2,
        ),
      ],
    );
  }
}

/// Info Snackbar Widget
/// Displays info messages with icon and styled appearance
class InfoSnackbar {
  InfoSnackbar._();

  /// Show an info snackbar with the given message
  static void show({
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    Get.snackbar(
      title ?? '',
      message,
      titleText: title != null
          ? Text(
              title,
              style: AppTextStyles.titleMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          : const SizedBox.shrink(),
      messageText: Row(
        children: [
          // Icon container with circular background
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon ?? Icons.info_outline,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          // Message text
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.info,
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderColor: const Color(0xFF1976D2),
      borderWidth: 1,
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      snackStyle: SnackStyle.FLOATING,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 20,
          offset: const Offset(0, 8),
          spreadRadius: 2,
        ),
      ],
    );
  }
}
