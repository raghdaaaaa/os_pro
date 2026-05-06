import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Constants/assets.dart';
import '../../../../Core/Widgets/app_scaffold.dart';
import '../../../../Core/Widgets/section_header.dart';
import '../../../Home/Controllers/home_controller.dart';
import '../Controllers/rewards_controller.dart';
import '../Widgets/achievement_card.dart';
import '../Widgets/stat_card.dart';
import '../Widgets/weekly_chart.dart';

class ProductivityScreen extends StatelessWidget {
  const ProductivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController    = context.read<HomeController>();
    final rewardsController = context.read<RewardsController>();

    return AppScaffold(
      currentNavIndex: 3,
      body: SafeArea(
        child: StreamBuilder(
          stream: homeController.tasksStream,
          builder: (context, taskSnapshot) {
            final allTasks   = taskSnapshot.data ?? [];
            final todayTasks = homeController.todayTasks(allTasks);
            final completed  = homeController.completedCount(todayTasks);
            final pending    = todayTasks.length - completed;

            return StreamBuilder<Map<String, dynamic>>(
              stream: rewardsController.rewardsStream,
              builder: (context, rewardsSnapshot) {
                final rewards = rewardsSnapshot.data ?? {'points': 0, 'badges': []};
                final points  = rewards['points'] as int? ?? 0;
                final badge   = rewardsController.badgeLabel(points);

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.productivityTitle,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(
                            child: StatCard(
                              value: completed.toString(),
                              label: AppStrings.productivityTasksLabel,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: StatCard(
                              value: pending.toString(),
                              label: AppStrings.productivityHoursLabel,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),

                      const SectionHeader(title: AppStrings.productivityWeeklyOverview),
                      const SizedBox(height: 16),
                      const WeeklyChart(),
                      const SizedBox(height: 60),

                      const SectionHeader(title: AppStrings.productivityRecentAchievement),
                      const SizedBox(height: 16),
                      AchievementCard(
                        icon: AppAssets.rewaed,
                        title: badge,
                        subtitle: '$points points',
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}