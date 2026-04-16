import 'package:flutter/material.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/assets.dart';

class ScheduleGrid extends StatelessWidget {
  const ScheduleGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column
        Expanded(
          child: Column(
            children: [
              _buildTaskCard(
                title: "Sketching in\nMy Journal",
                time: "08:00 - 10:00",
                color: AppColors.accentBeige,
                image: AppAssets.taskSketching,
                isTall: true,
              ),
              const SizedBox(height: 10),
              _buildViewMoreCard(),
            ],
          ),
        ),
        const SizedBox(width: 25),
        // Right Column
        Expanded(
          child: Column(
            children: [
              _buildTaskCard(
                title: "Coffee with\nthe Dev Team",
                time: "07:00 - 08:00",
                color: Colors.white,
                hasShadow: true,
              ),
              const SizedBox(height: 6),
              _buildTaskCard(
                title: "Plan\nTomorrow's\nWins",
                time: "11:00 - 12:00",
                color: AppColors.accentBeige,
                image: AppAssets.taskPlan,
                isTall: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard({
    required String title,
    required String time,
    required Color color,
    String? image,
    bool hasShadow = false,
    bool isTall = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: hasShadow || color == Colors.white
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'Poppins',
              height: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary.withAlpha(150),
              fontFamily: 'Poppins',
            ),
          ),
          if (image != null) ...[
            const SizedBox(height: 15),
            Center(
              child: Image.asset(
                image,
                height: isTall ? 120 : 90,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildViewMoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        children: [
          Text(
            "Click to view\nmore",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              height: 1.2,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "+5 Schedule",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
