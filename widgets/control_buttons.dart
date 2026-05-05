import 'package:flutter/material.dart';
import '../color/color.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Stop button
        CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.secondary,
          child: IconButton(
            icon: const Icon(Icons.stop_rounded, color: AppColors.primary, size: 28),
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 24),
        // Pause button
        CircleAvatar(
          radius: 36,
          backgroundColor: AppColors.primary,
          child: IconButton(
            icon: const Icon(Icons.pause_rounded, color: Colors.white, size: 28),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}