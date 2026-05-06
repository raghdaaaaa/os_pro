import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brain_stack/Core/Routing/router.dart';
import 'package:brain_stack/Core/Routing/routes.dart';

// Controllers
import 'package:brain_stack/Featurs/Auth/Presentation/controllers/auth_controller.dart';
import 'package:brain_stack/Featurs/Add_Task/Presentation/controllers/task_controller.dart';
import 'package:brain_stack/Featurs/Focus Mode/Presentation/controllers/timer_controller.dart';
import 'package:brain_stack/Featurs/Profile/Presentation/controllers/profile_controller.dart';
import 'package:brain_stack/Featurs/Schedule/Presentation/controllers/calendar_controller.dart';

// Services
import 'package:brain_stack/services/notification_service.dart';

import 'Featurs/Home/Controllers/home_controller.dart';
import 'Featurs/Productivity/Presentation/Controllers/rewards_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initialize();
  runApp(const BrainStack());
}

class BrainStack extends StatelessWidget {
  const BrainStack({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => TaskController()),
        ChangeNotifierProvider(create: (_) => TimerController()),
        ChangeNotifierProvider(create: (_) => RewardsController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => CalendarController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.onboardingScreen,
      ),
    );
  }
}