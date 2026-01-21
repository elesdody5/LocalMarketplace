

import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:presentation/onboarding/onboarding_screen.dart';
import 'package:presentation/routes/routes.dart';
import 'package:presentation/auth/signup/signup_screen.dart';
import 'package:presentation/auth/login/login_screen.dart';
import 'package:presentation/home/home_screen.dart';
import 'package:presentation/welcome/welcome_screen.dart';

final appPages = [
      // GetPage(name: splashRouteName, page: () => const SplashScreen()),
   GetPage(
           name: welcomeRouteName,
           page: () => const WelcomeScreen(),
           transition: Transition.cupertino,
           transitionDuration: const Duration(milliseconds: 300),
         ),
         GetPage(
           name: onBoardingRouteName,
           page: () => const OnboardingScreen(),
           transition: Transition.cupertino,
           transitionDuration: const Duration(milliseconds: 300),
         ),
         GetPage(
           name: signupRouteName,
           page: () => SignupScreen(),
           transition: Transition.cupertino,
           transitionDuration: const Duration(milliseconds: 300),
         ),
         GetPage(
           name: loginRouteName,
           page: () => LoginScreen(),
           transition: Transition.cupertino,
           transitionDuration: const Duration(milliseconds: 300),
         ),
         GetPage(
           name: homeRouteName,
           page: () => const HomeScreen(),
           transition: Transition.cupertino,
           transitionDuration: const Duration(milliseconds: 300),
         ),
];
