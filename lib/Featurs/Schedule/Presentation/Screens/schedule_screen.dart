import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brain_stack/Featurs/Focus%20Mode/Presentation/Screens/focus_mode_screen.dart';
import 'package:brain_stack/Featurs/Schedule/Presentation/Widgets/day_selector.dart';
import 'package:brain_stack/Featurs/Schedule/Presentation/controllers/calendar_controller.dart';
import 'package:brain_stack/models/task_model.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Widgets/app_scaffold.dart';
import '../../../../Core/Widgets/app_loader.dart';
import '../../../../Core/Widgets/section_header.dart';
import '../../../../Core/Widgets/task_card.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CalendarController>();

    return AppScaffold(
      currentNavIndex: 1,
      body: SafeArea(
        child: StreamBuilder<List<TaskModel>>(
          stream: controller.allTasksStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoader();
            }

            final allTasks = snapshot.data ?? [];
            final dayTasks = controller.tasksForDate(allTasks, controller.selectedDate);

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + Search
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        AppStrings.scheduleTitle,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Day Selector
                  DaySelector(
                    onDaySelected: (date) => controller.selectDate(date),
                  ),
                  const SizedBox(height: 28),

                  // Tasks Header
                  const SectionHeader(title: AppStrings.scheduleTodayTasks),
                  const SizedBox(height: 16),

                  // Tasks من Firebase
                  if (dayTasks.isEmpty)
                    _buildEmptyState()
                  else
                  // ✅ بنمرر context هنا عشان نقدر نعمل Navigator جوا الـ method
                    ...dayTasks.map((task) => _buildTaskCard(context, task)),

                  const SizedBox(height: 100),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ✅ context اتضاف كأول parameter
  Widget _buildTaskCard(BuildContext context, TaskModel task) {
    final timeRange = (task.startTime.isNotEmpty && task.endTime.isNotEmpty)
        ? '${task.startTime} - ${task.endTime}'
        : 'No time set';

    final bgColor = task.priority == 'high'
        ? AppColors.primaryCardColor
        : task.priority == 'medium'
        ? AppColors.primaryCard10Color
        : AppColors.backgroundColor;

    final showBorder = task.priority == 'low';

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TaskCard(
        title: task.title,
        backgroundColor: bgColor,
        border: showBorder
            ? Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.7),
          width: 1.5,
        )
            : null,
        timeRange: timeRange,
        teamLabel: task.isCompleted ? '✅ Completed' : null,
        showFocusButton: !task.isCompleted,
        // ✅ الربط هنا — بيفتح FocusModeScreen مع بيانات الـ task
        onFocusTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FocusModeScreen(
                taskId: task.id ?? '',
                taskTitle: task.title,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          'No tasks for this day 🎉',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}