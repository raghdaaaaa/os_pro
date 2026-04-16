import 'package:flutter/material.dart';
import 'package:brain_stack/Core/Constants/app_color.dart';
import '../Widgets/home_header.dart';
import '../Widgets/progress_card.dart';
import '../Widgets/schedule_grid.dart';
import '../../../../Core/Constants/assets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      bottomNavigationBar: _buildBottomNavBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const HomeHeader(),
              const SizedBox(height: 40),
              const ProgressCard(),
              const SizedBox(height: 45),
              const ScheduleGrid(),
              const SizedBox(height: 130), // Ample space for the tall bottom bar
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 55,
        width: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(60),
              blurRadius: 40,
              offset: const Offset(10, 20),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
          shape: const CircleBorder(),
          elevation: 0,
          child: const Icon(Icons.add, color: Colors.white, size: 35),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavBar() {
    return BottomAppBar(
      height: 65,
      shape: const CircularNotchedRectangle(),
      notchMargin: 15,
      color: Colors.white,
      elevation: 40,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(child: _navItem(AppAssets.frame1, isActive: true)),
          Expanded(child: _navItem(AppAssets.frame2)),
          const SizedBox(width: 70), // Matches the FAB width
          Expanded(child: _navItem(AppAssets.frame4)),
          Expanded(child: _navItem(AppAssets.frame5)),
        ],
      ),
    );
  }

  Widget _navItem(String asset, {bool isActive = false}) {
    return GestureDetector(
      onTap: () {},
      child: Center(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            isActive ? AppColors.accentBeige : Colors.grey.shade400,
            BlendMode.srcIn,
          ),
          child: Image.asset(
            asset,
            width: 35,
            height: 35,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
