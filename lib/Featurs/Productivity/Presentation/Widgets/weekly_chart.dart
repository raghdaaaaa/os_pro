import 'package:flutter/material.dart';
import '../../../../Core/Constants/app_color.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

   static const List<double> _values = [0.5, 0.8, 0.50, 0.9, 0.7, 1.0, 0.4];
  static const List<String> _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
  static const int _activeIndex = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 24, 20, 25),
      decoration: BoxDecoration(
        color: AppColors.primaryCard10Color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_values.length, (index) {
                final isActive = index == _activeIndex;
                return _Bar(
                  heightFactor: _values[index],
                  isActive: isActive,
                );
              }),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _days.map((day) {
              return Text(
                day,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.primaryColor,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final double heightFactor;
  final bool isActive;

  const _Bar({required this.heightFactor, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.5,
      height: 125 * heightFactor,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primaryColor : AppColors.primaryCardColor,
        borderRadius: BorderRadius.circular(9),
      ),
    );
  }
}
