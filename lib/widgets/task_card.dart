import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class TaskCard extends StatelessWidget {
  final String time;
  final String title;
  final Color color;
  final String? subtitle;
  final bool showDevIcon;
  final bool showStroke;
  final bool isEmptyBottom;

  const TaskCard({
    super.key,
    required this.time,
    required this.title,
    required this.color,
    this.subtitle,
    this.showDevIcon = false,
    this.showStroke = false,
    this.isEmptyBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: showStroke ? AppColors.primaryDark : Colors.transparent, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(time, style: TextStyle(color: AppColors.primaryDark.withOpacity(0.5), fontSize: 11, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(color: AppColors.primaryDark, fontSize: 19, fontWeight: FontWeight.w800, height: 1.2)),
          if (!isEmptyBottom) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (showDevIcon) const Icon(Icons.code_rounded, size: 16, color: AppColors.primaryDark),
                    if (showDevIcon) const SizedBox(width: 6),
                    if (subtitle != null) Text(subtitle!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  decoration: BoxDecoration(color: AppColors.primaryDark, borderRadius: BorderRadius.circular(14)),
                  child: const Text("focus mode", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}