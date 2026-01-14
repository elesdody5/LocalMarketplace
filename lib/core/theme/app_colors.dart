import 'package:flutter/material.dart';

/// App color palette for the Local Marketplace app
/// Colors are chosen to reflect Saudi market preferences and ensure good accessibility
class AppColors {
  AppColors._();

  // Primary colors - Blue tones for professional marketplace
  static const Color primaryGreen = Color(0xFF0c5678);
  static const Color primaryGreenLight = Color(0xFFeef6f9);
  static const Color primaryGreenDark = Color(0xFF08415c);

  // Secondary colors - Kept for compatibility
  static const Color secondaryGold = Color(0xFFD4AF37);
  static const Color secondaryGoldLight = Color(0xFFFFD700);
  static const Color secondaryGoldDark = Color(0xFFB8941D);

  // Neutral colors for light theme
  static const Color backgroundLight = Color(0xFFf3f4f6);
  static const Color surfaceLight = Color(0xFFffffff);
  static const Color textPrimaryLight = Color(0xFF1f2937);
  static const Color textSecondaryLight = Color(0xFF6b7280);
  static const Color dividerLight = Color(0xFFE0E0E0);

  // Neutral colors for dark theme
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1f2937);
  static const Color textPrimaryDark = Color(0xFFf9fafb);
  static const Color textSecondaryDark = Color(0xFF9ca3af);
  static const Color dividerDark = Color(0xFF333333);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF42A5F5);

  // Category colors (for different product categories)
  static const Color categoryElectronics = Color(0xFF2196F3);
  static const Color categoryFashion = Color(0xFFE91E63);
  static const Color categoryHome = Color(0xFF795548);
  static const Color categoryVehicles = Color(0xFF607D8B);
  static const Color categoryRealEstate = Color(0xFF9C27B0);

  // Verified badge color
  static const Color verified = Color(0xFF00BFA5);
}
