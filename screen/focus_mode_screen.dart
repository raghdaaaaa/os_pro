import 'package:flutter/material.dart';
import '../color/color.dart';
import '../widgets/timer_section.dart';
import '../widgets/control_buttons.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Status Bar (Time, battery, and network status icons)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "9:41",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 16,
                        height: 12,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. Main Screen Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Focus Mode",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    // 3. Current Task Information and Details
                    const Text(
                      "UI Wireframing",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_offer_outlined,
                          size: 16,
                          color: Colors.brown,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Design Task",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // 4. Circular Progress Timer Section (Reads secondary color from AppColors)
                    const TimerSection(),

                    const SizedBox(height: 48),

                    // 5. Timer Control Buttons (Play/Pause/Stop)
                    const ControlButtons(),

                    const SizedBox(height: 56),

                    // 6. Give Up Button (Styled with the new secondary background color FFF3D9 and primary text)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColors.secondary, // Background color FFF3D9
                        foregroundColor: AppColors
                            .primary, // Text color (Dark brown) for optimal contrast
                        elevation:
                            0, // Disable shadow for a clean, modern flat design
                        padding: const EdgeInsets.symmetric(
                          horizontal: 48,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Give Up",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
