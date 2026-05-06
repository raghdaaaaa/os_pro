import 'package:flutter/material.dart';
import '../../../../Core/Constants/app_color.dart';

class ProgressCard extends StatelessWidget {
  final double progress;
  final String message;

  const ProgressCard({
    super.key,
    required this.progress,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final barWidth = (screenWidth - 48 - 130 - 50) * progress;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(42),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(60),
            blurRadius: 30,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.normal,
              fontFamily: 'Cairo',
              height: 1.3,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 47,
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/schedule');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryCardColor,
                    foregroundColor: AppColors.textPrimary,
                    elevation: 0,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    "View Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(40),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    width: barWidth.clamp(0, 100),
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.primaryCardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
