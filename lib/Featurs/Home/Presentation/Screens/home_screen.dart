import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Routing/routes.dart';
import '../../../../Core/Widgets/app_scaffold.dart';
import '../../Controllers/home_controller.dart';
import '../Widgets/home_header.dart';
import '../Widgets/progress_card.dart';
import 'package:brain_stack/models/task_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeController>();

    return AppScaffold(
      currentNavIndex: 0,
      body: SafeArea(
        child: StreamBuilder<List<TaskModel>>(
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

                  // Progress Card
                  ProgressCard(
                    progress: progress,
                    message: total == 0
                        ? "No tasks for today!"
                        : "You've completed\n$completed/$total of today's goals",
                  ),
                  const SizedBox(height: 45),

                  if (todayTasks.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'No tasks for today!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    ...todayTasks.map(
                        (task) => _buildTaskCard(context, task, controller)),

                  const SizedBox(height: 130),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTaskCard(
      BuildContext context, TaskModel task, HomeController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: task.priority == 'high'
              ? AppColors.primaryCardColor
              : task.priority == 'medium'
                  ? AppColors.primaryCard10Color
                  : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  if (task.startTime.isNotEmpty)
                    Text(
                      '${task.startTime} - ${task.endTime}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            if (!task.isCompleted)
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.scheduleScreen,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Focus',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                ),
              )
            else
              const Icon(Icons.check_circle, color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
