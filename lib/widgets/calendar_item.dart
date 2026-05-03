import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CalendarItem extends StatelessWidget {
  final String day;
  final String date;
  final bool isActive;

  const CalendarItem({
    super.key,
    required this.day,
    required this.date,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 74.0,
      height: 86.0,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primaryDark,
          width: isActive ? 0 : 1.2,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day,
              style: TextStyle(
                color: isActive ? Colors.white70 : AppColors.textGrey,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.primaryDark,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
