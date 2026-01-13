import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Demo screen showcasing the theme configuration
/// This screen displays various styled components to verify theme implementation
class ThemeDemo extends StatelessWidget {
  const ThemeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Typography section
          Text('Display Large', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 8),
          Text('Headline Medium', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text('Title Large', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text('Body Large', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8),
          Text('Body Medium', style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text('Label Small', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(height: 24),

          // Buttons section
          const Text('Buttons:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Elevated Button'),
          ),
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () {},
            child: const Text('Outlined Button'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('Text Button'),
          ),
          const SizedBox(height: 24),

          // Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card Component',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('This is a card with the themed styling.',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Input field
          const TextField(
            decoration: InputDecoration(
              labelText: 'Input Field',
              hintText: 'Enter text here',
            ),
          ),
          const SizedBox(height: 24),

          // Chips
          const Text('Chips:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: const Text('Electronics'), backgroundColor: AppColors.categoryElectronics),
              Chip(label: const Text('Fashion'), backgroundColor: AppColors.categoryFashion),
              Chip(label: const Text('Vehicles'), backgroundColor: AppColors.categoryVehicles),
            ],
          ),
          const SizedBox(height: 24),

          // Colors section
          const Text('Color Palette:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _colorBox('Primary', AppColors.primaryGreen)),
              const SizedBox(width: 8),
              Expanded(child: _colorBox('Secondary', AppColors.secondaryGold)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _colorBox('Success', AppColors.success)),
              const SizedBox(width: 8),
              Expanded(child: _colorBox('Error', AppColors.error)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _colorBox('Warning', AppColors.warning)),
              const SizedBox(width: 8),
              Expanded(child: _colorBox('Verified', AppColors.verified)),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _colorBox(String label, Color color) {
    // Calculate contrasting text color based on background brightness
    final brightness = ThemeData.estimateBrightnessForColor(color);
    final textColor = brightness == Brightness.dark ? Colors.white : Colors.black;
    
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
