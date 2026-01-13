import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_marketblace/core/theme/app_colors.dart';
import 'package:local_marketblace/core/theme/app_theme.dart';

void main() {
  group('AppTheme Tests', () {
    test('Light theme should be properly configured', () {
      final lightTheme = AppTheme.lightTheme;

      // Verify brightness
      expect(lightTheme.brightness, Brightness.light);

      // Verify Material 3 is enabled
      expect(lightTheme.useMaterial3, true);

      // Verify color scheme
      expect(lightTheme.colorScheme.primary, AppColors.primaryGreen);
      expect(lightTheme.colorScheme.secondary, AppColors.secondaryGold);
      expect(lightTheme.colorScheme.surface, AppColors.surfaceLight);
      expect(lightTheme.colorScheme.background, AppColors.backgroundLight);

      // Verify text theme exists
      expect(lightTheme.textTheme, isNotNull);
      expect(lightTheme.textTheme.bodyLarge, isNotNull);
      expect(lightTheme.textTheme.headlineMedium, isNotNull);

      // Verify app bar theme
      expect(lightTheme.appBarTheme.backgroundColor, AppColors.primaryGreen);
      expect(lightTheme.appBarTheme.centerTitle, true);

      // Verify card theme
      expect(lightTheme.cardTheme.elevation, 2);
      expect(lightTheme.cardTheme.color, AppColors.surfaceLight);
    });

    test('Dark theme should be properly configured', () {
      final darkTheme = AppTheme.darkTheme;

      // Verify brightness
      expect(darkTheme.brightness, Brightness.dark);

      // Verify Material 3 is enabled
      expect(darkTheme.useMaterial3, true);

      // Verify color scheme
      expect(darkTheme.colorScheme.primary, AppColors.primaryGreenLight);
      expect(darkTheme.colorScheme.secondary, AppColors.secondaryGoldLight);
      expect(darkTheme.colorScheme.surface, AppColors.surfaceDark);
      expect(darkTheme.colorScheme.background, AppColors.backgroundDark);

      // Verify text theme exists
      expect(darkTheme.textTheme, isNotNull);
      expect(darkTheme.textTheme.bodyLarge, isNotNull);
      expect(darkTheme.textTheme.headlineMedium, isNotNull);

      // Verify app bar theme
      expect(darkTheme.appBarTheme.backgroundColor, AppColors.surfaceDark);
      expect(darkTheme.appBarTheme.centerTitle, true);

      // Verify card theme
      expect(darkTheme.cardTheme.elevation, 2);
      expect(darkTheme.cardTheme.color, AppColors.surfaceDark);
    });

    test('Button themes should have consistent styling', () {
      final lightTheme = AppTheme.lightTheme;

      // Verify elevated button theme
      expect(lightTheme.elevatedButtonTheme.style, isNotNull);
      
      // Verify outlined button theme
      expect(lightTheme.outlinedButtonTheme.style, isNotNull);
      
      // Verify text button theme
      expect(lightTheme.textButtonTheme.style, isNotNull);
    });

    test('Input decoration theme should be configured', () {
      final lightTheme = AppTheme.lightTheme;
      final inputTheme = lightTheme.inputDecorationTheme;

      expect(inputTheme.filled, true);
      expect(inputTheme.fillColor, AppColors.surfaceLight);
      expect(inputTheme.border, isNotNull);
      expect(inputTheme.focusedBorder, isNotNull);
    });

    test('Light and dark themes should have different colors', () {
      final lightTheme = AppTheme.lightTheme;
      final darkTheme = AppTheme.darkTheme;

      // Primary colors should differ
      expect(lightTheme.colorScheme.primary, isNot(equals(darkTheme.colorScheme.primary)));
      
      // Background colors should differ
      expect(lightTheme.colorScheme.background, isNot(equals(darkTheme.colorScheme.background)));
      
      // Surface colors should differ
      expect(lightTheme.colorScheme.surface, isNot(equals(darkTheme.colorScheme.surface)));
    });
  });

  group('AppColors Tests', () {
    test('Primary colors should be defined', () {
      expect(AppColors.primaryGreen, isNotNull);
      expect(AppColors.primaryGreenLight, isNotNull);
      expect(AppColors.primaryGreenDark, isNotNull);
    });

    test('Secondary colors should be defined', () {
      expect(AppColors.secondaryGold, isNotNull);
      expect(AppColors.secondaryGoldLight, isNotNull);
      expect(AppColors.secondaryGoldDark, isNotNull);
    });

    test('Status colors should be defined', () {
      expect(AppColors.success, isNotNull);
      expect(AppColors.error, isNotNull);
      expect(AppColors.warning, isNotNull);
      expect(AppColors.info, isNotNull);
    });

    test('Category colors should be defined', () {
      expect(AppColors.categoryElectronics, isNotNull);
      expect(AppColors.categoryFashion, isNotNull);
      expect(AppColors.categoryHome, isNotNull);
      expect(AppColors.categoryVehicles, isNotNull);
      expect(AppColors.categoryRealEstate, isNotNull);
    });

    test('Verified badge color should be defined', () {
      expect(AppColors.verified, isNotNull);
    });
  });
}
