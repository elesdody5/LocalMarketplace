import 'package:domain/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_market_place/pages/app_pages.dart';
import 'package:presentation/di/injection.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/theme/app_theme.dart';

import 'localization/messages.dart';
import 'screens/theme_demo.dart';

void main() {
  configurePresentationDependencies();
  configureDomainDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Local Marketblace',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      translations: Messages(),
      locale: const Locale("en"),
      fallbackLocale: const Locale('en'),
      getPages: appPages,
      initialRoute: onBoardingRouteName,
    );
  }
}

class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() {
    counter++;
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Obx(() => Text(
                  '${controller.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                )),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Get.to(() => const ThemeDemo());
              },
              icon: const Icon(Icons.palette),
              label: const Text('View Theme Demo'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
