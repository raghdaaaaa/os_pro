import 'package:flutter/material.dart';
import 'package:brain_stack/Core/Routing/router.dart';
import 'package:brain_stack/Core/Routing/routes.dart';

void main() {
  runApp(const BrainStack());
}

class BrainStack extends StatelessWidget {
  const BrainStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute, 
      initialRoute: AppRoutes.onboardingScreen,
    );
  }
}