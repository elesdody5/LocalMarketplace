import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Placeholder Home Screen
/// This is a temporary screen that will be replaced with the actual home/browse screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Cache theme values at build start
    final theme = Get.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = Get.textTheme;

    // Pre-calculate alpha colors for performance
    final primaryLightBackground = colorScheme.primary.withValues(alpha: 0.1);
    final onSurfaceMuted = colorScheme.onSurface.withValues(alpha: 0.6);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Home',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: primaryLightBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_outline,
                  size: 64,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),

              // Welcome Message
              Text(
                'Login Successful!',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Subtitle
              Text(
                'Welcome to the marketplace. This is a placeholder home screen.',
                style: textTheme.bodyLarge?.copyWith(
                  color: onSurfaceMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),

              // Logout Button
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate back to welcome screen
                  Get.offAllNamed('/welcome_screen');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
