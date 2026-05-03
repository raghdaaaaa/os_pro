import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../widgets/calendar_item.dart';
import '../widgets/task_card.dart';
import '../widgets/custom_bottom_nav.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            //  calendar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  CalendarItem(day: "Mon", date: "12", isActive: false),
                  CalendarItem(day: "Tue", date: "13", isActive: true),
                  CalendarItem(day: "Wed", date: "14", isActive: false),
                  CalendarItem(day: "Thu", date: "15", isActive: false),
                ],
              ),
            ),
            //  tasks
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: const [
                  Text("Today's Tasks", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
                  SizedBox(height: 20),
                  TaskCard(time: "08:00 AM - 10:00 AM", title: "Sketching UI Wireframes", color: AppColors.cardCream, subtitle: "design Team"),
                  TaskCard(time: "11:00 AM - 01:00 PM", title: "Flutter API Integration", color: AppColors.cardOrange, subtitle: "Dev Team", showDevIcon: true),
                  TaskCard(time: "03:00 PM - 04:00 PM", title: "Review Project Document", color: Colors.white, showStroke: true, isEmptyBottom: true),
                ],
              ),
            ),
            const CustomBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.primaryDark)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: AppColors.primaryDark, size: 28)),
        ],
      ),
    );
  }
}