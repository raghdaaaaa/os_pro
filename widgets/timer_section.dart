import 'package:flutter/material.dart';
import '../color/color.dart';

class TimerSection extends StatelessWidget {
  const TimerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SizedBox(
          width: 240,
          height: 240,
          child: CircularProgressIndicator(
            value: 0.35, 
            strokeWidth: 12,
            backgroundColor: AppColors.secondary,
            color: AppColors.primary,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "24:59",
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 58,
                fontWeight: FontWeight.w800,
                letterSpacing: -1.5,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            Text(
              "Remaining",
              style: TextStyle(
                color: AppColors.primary.withOpacity(0.5),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
          ],
        ),
      ],
    );
  }
}