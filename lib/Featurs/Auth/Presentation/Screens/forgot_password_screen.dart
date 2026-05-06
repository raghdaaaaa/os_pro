import 'package:flutter/material.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Constants/assets.dart';
import '../../../../Core/Routing/routes.dart';
import '../Widgets/auth_text_field.dart';
import '../Widgets/auth_back_button.dart';
import '../../../../Core/Widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthBackButton(),
              const SizedBox(height: 60),
              const Text(
                AppStrings.forgotPasswordTitle,
                style: TextStyle(
                  fontSize: 23.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                AppStrings.forgotPasswordSubTitle,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.textSecondary,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 40),
              const AuthTextField(
                hint: AppStrings.forgotPasswordEmailHint,
                prefixIconPath: AppAssets.user,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Routing
              PrimaryButton(
                label: AppStrings.forgotPasswordConfirmButton,
                onPressed: () =>
                    Navigator.pushNamed(context, AppRoutes.otpScreen),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
