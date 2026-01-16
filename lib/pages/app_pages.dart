

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:presentation/onboarding/onboarding_screen.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/signup/signup_screen.dart';
import 'package:presentation/welcome/welcome_screen.dart';

final appPages = [
      // GetPage(name: splashRouteName, page: () => const SplashScreen()),
      GetPage(name: welcomeRouteName, page: () => const WelcomeScreen()),
      GetPage(name: onBoardingRouteName, page: () => const OnboardingScreen()),
      GetPage(name: signupRouteName, page: () => const SignupScreen())];
