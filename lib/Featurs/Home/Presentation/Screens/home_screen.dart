import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Core/Widgets/app_scaffold.dart';
import '../../Controllers/home_controller.dart';
import '../Widgets/home_header.dart';
import '../Widgets/progress_card.dart';
import '../Widgets/schedule_grid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();

    return AppScaffold(
      currentNavIndex: 0,
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.tasksStream,
          builder: (context, snapshot) {
            final allTasks = snapshot.data ?? [];
            final todayTasks = controller.todayTasks(allTasks);
            final progress = controller.completionRate(todayTasks);
            final completed = controller.completedCount(todayTasks);
            final total = todayTasks.length;

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const HomeHeader(),
                  const SizedBox(height: 40),
                  ProgressCard(
                    progress: progress,
                    message: total == 0
                        ? "No tasks for today!"
                        : "You've completed\n$completed/$total of today's goals",
                  ),
                  const SizedBox(height: 45),
                  const ScheduleGrid(),
                  const SizedBox(height: 130),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}