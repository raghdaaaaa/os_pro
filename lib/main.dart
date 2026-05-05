import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:brain_stack/Core/Routing/router.dart';
import 'package:brain_stack/Core/Routing/routes.dart';

// Controllers
import 'package:brain_stack/Featurs/Auth/controllers/auth_controller.dart';
import 'package:brain_stack/Featurs/Home/controllers/home_controller.dart';
import 'package:brain_stack/Featurs/Task/controllers/task_controller.dart';
import 'package:brain_stack/Featurs/Timer/controllers/timer_controller.dart';
import 'package:brain_stack/Featurs/Rewards/controllers/rewards_controller.dart';
import 'package:brain_stack/Featurs/Profile/controllers/profile_controller.dart';
import 'package:brain_stack/Featurs/Calendar/controllers/calendar_controller.dart';

// Services
import 'package:brain_stack/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initialize(); // ask for notification permission
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