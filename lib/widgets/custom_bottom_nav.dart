import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -8))],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [Icon(Icons.grid_view_rounded, color: AppColors.textGrey, size: 28), SizedBox(width: 35), Icon(Icons.calendar_today_rounded, color: AppColors.primaryDark, size: 28)]),
                  SizedBox(width: 50),
                  Row(children: [Icon(Icons.bar_chart_rounded, color: AppColors.textGrey, size: 30), SizedBox(width: 35), Icon(Icons.person_outline_rounded, color: AppColors.textGrey, size: 30)]),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 64, width: 64,
              decoration: BoxDecoration(
                color: AppColors.borderLight, 
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 5))],
              ),
              child: const Icon(Icons.add, color: AppColors.primaryDark, size: 35),
            ),
          ),
        ],
      ),
    );
  }
}