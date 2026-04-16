import 'package:flutter/material.dart';
import './routes.dart';
import '../../../Featurs/Auth/Presentation/Screens/signin_screen.dart';
import '../../../Featurs/Auth/Presentation/Screens/signup_screen.dart';
import '../../../Featurs/Auth/Presentation/Screens/home_screen.dart';
import '../../../Featurs/Onboarding/Presentation/Screens/onboarding_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (_) => const SigninScreen());

      case AppRoutes.signupScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}
