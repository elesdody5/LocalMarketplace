# Theme Configuration Guide

This document describes the theming system for the Local Marketplace application.

## Overview

The app uses a comprehensive theming system with support for both light and dark modes, using Manrope font via Google Fonts, and a professional blue color scheme.

## Structure

The theme configuration is located in `lib/core/theme/` and consists of three main files:

### 1. `app_colors.dart`
Defines all color constants used throughout the app:

- **Primary Colors**: Blue tones for professional marketplace
  - `primaryGreen`: #0c5678
  - `primaryGreenLight`: #eef6f9 (light background)
  - `primaryGreenDark`: #08415c (hover state)

- **Secondary Colors**: Gold/Amber tones (maintained for compatibility)
  - `secondaryGold`: #D4AF37
  - `secondaryGoldLight`: #FFD700
  - `secondaryGoldDark`: #B8941D

- **Neutral Colors**: 
  - Light theme: #f3f4f6 (background), #ffffff (surface), #1f2937 (text), #6b7280 (subtext)
  - Dark theme: #111827 (background), #1f2937 (surface), #f9fafb (text), #9ca3af (subtext)

- **Status Colors**: For success, error, warning, and info states
- **Category Colors**: For different product categories

### 2. `app_text_styles.dart`
Defines typography styles following Material Design 3 guidelines:

- Display styles (largest text)
- Headline styles
- Title styles
- Body styles
- Label styles
- Custom price styles (specific to marketplace needs)

All text styles use Manrope font for clean, modern typography.

### 3. `app_theme.dart`
Main theme configuration that combines colors and text styles:

- Provides `lightTheme` and `darkTheme` static getters
- Uses Google Fonts (Manrope) for clean typography
- Default border radius: 12px (0.75rem)
- Configures all Material Design components:
  - AppBar
  - Cards
  - Buttons (Elevated, Outlined, Text)
  - Input fields
  - Chips
  - Dialogs
  - SnackBars
  - Bottom navigation
  - And more...

## Usage

### Basic Usage

The theme is already configured in `main.dart`:

```dart
import 'core/theme/app_theme.dart';

GetMaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // Automatically switches based on system settings
  // ...
)
```

### Accessing Theme Colors

```dart
// Get current theme colors
final primaryColor = Theme.of(context).colorScheme.primary;
final surfaceColor = Theme.of(context).colorScheme.surface;

// Or use colors directly
import 'package:local_marketblace/core/theme/app_colors.dart';
Container(color: AppColors.primaryGreen)
```

### Using Text Styles

```dart
// Use theme text styles
Text('Title', style: Theme.of(context).textTheme.titleLarge)
Text('Body', style: Theme.of(context).textTheme.bodyMedium)

// Or use text styles directly
import 'package:local_marketblace/core/theme/app_text_styles.dart';
Text('Price', style: AppTextStyles.priceMain)
```

### Theme Mode Switching

To add theme mode switching in the future:

```dart
// In your controller/state management
var themeMode = ThemeMode.system.obs;

// In your GetMaterialApp
GetMaterialApp(
  themeMode: themeMode.value,
  // ...
)

// To switch themes
themeMode.value = ThemeMode.dark; // or ThemeMode.light
```

## Design Decisions

### Color Choices
- **Blue (#0c5678)**: Chosen as the primary color for professional, trustworthy appearance
- **Gold**: Secondary color maintained for premium quality and accents
- **High Contrast**: Text colors ensure WCAG AA compliance for accessibility
- **Light Backgrounds**: #eef6f9 and #f3f4f6 for subtle, modern interface

### Typography
- **Manrope Font**: Chosen for clean, modern typography with excellent readability
- **Material Design 3**: Following the latest design guidelines for consistency
- **Scalable**: Font sizes follow a modular scale for visual hierarchy

### Component Styling
- **Rounded Corners**: 12px (0.75rem) default border radius for modern appearance
- **Elevation**: Conservative use of shadows for depth without overwhelming
- **Spacing**: Consistent padding and margins following 8px grid system

## Customization

### Adding New Colors

1. Add color constant to `app_colors.dart`:
```dart
static const Color myNewColor = Color(0xFF123456);
```

2. Use in theme or directly in widgets

### Adding New Text Styles

1. Add style to `app_text_styles.dart`:
```dart
static const TextStyle myCustomStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
```

2. Optionally add to theme's textTheme in `app_theme.dart`

### Modifying Existing Theme

Edit the respective theme configuration in `app_theme.dart`:

```dart
// Example: Change card elevation
cardTheme: CardTheme(
  elevation: 4, // Changed from 2
  // ...
),
```

## Testing

Theme tests are located in `test/theme_test.dart` and verify:
- Both themes are properly configured
- Colors are correctly assigned
- Component themes are set up
- Light and dark themes have appropriate differences

Run tests with:
```bash
flutter test test/theme_test.dart
```

## Future Enhancements

Potential improvements to the theme system:

1. **Theme Switching UI**: Add a settings page to manually switch themes
2. **Custom Font Sizes**: Allow users to adjust font size for accessibility
3. **Accent Colors**: Support for user-customizable accent colors
4. **High Contrast Mode**: Additional theme variant for users with visual impairments
5. **RTL Support**: Enhanced right-to-left layout support for Arabic
