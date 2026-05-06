import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brain_stack/Featurs/Focus%20Mode/Presentation/Widgets/timer_circle.dart';
import 'package:brain_stack/Featurs/Focus%20Mode/Presentation/Widgets/timer_controls.dart';
import 'package:brain_stack/Featurs/Focus%20Mode/Presentation/controllers/timer_controller.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Widgets/app_scaffold.dart';

class FocusModeScreen extends StatefulWidget {
  final String taskId;
  final String taskTitle;

  const FocusModeScreen({
    super.key,
    required this.taskId,
    required this.taskTitle,
  });

  @override
  State<FocusModeScreen> createState() => _FocusModeScreenState();
}

class _FocusModeScreenState extends State<FocusModeScreen> {
  @override
  void initState() {
    super.initState();
     Future.microtask(() {
      context.read<TimerController>().setTask(widget.taskId, widget.taskTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TimerController>();

     final isBreak = controller.isBreak;

    return AppScaffold(
      showBottomNav: false,
      showFab: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                isBreak ? '☕ Break Time' : AppStrings.focusModeTitle,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w800,
                  fontSize: 30,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 40),

              // Task Name + Sessions Counter
              Column(
                children: [
                  Text(
                    widget.taskTitle,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      color: AppColors.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.label,
                        size: 14,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                         'Session ${controller.sessionsCompleted + 1} of 4',
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 50),

               Center(
                child: TimerCircle(
                  progress: controller.progress,
                  timeText: controller.timeDisplay,
                ),
              ),
              const SizedBox(height: 50),

               Center(
                child: TimerControls(
                  isRunning: controller.isRunning,
                  onStop: () => controller.reset(),
                  onPlayPause: controller.isRunning
                      ? () => controller.pause()
                      : () => controller.start(),
                ),
              ),
              const SizedBox(height: 55),

              // Give Up Button
              Center(
                child: OutlinedButton(
                  onPressed: () {
                    controller.pause();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 55,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    AppStrings.focusModeGiveUp,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),

              const Spacer(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}