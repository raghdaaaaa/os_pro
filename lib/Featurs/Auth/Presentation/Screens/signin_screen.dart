import 'package:flutter/material.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Constants/assets.dart';
import '../../../../Core/Routing/routes.dart';
import '../Widgets/auth_text_field.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // Illustration
              Center(
                child: Image.asset(
                  AppAssets.signin,
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              
              // Titles
              const Text(
                AppStrings.signInTitle,
                style: TextStyle(
                  fontSize: 23.5,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 11),
              const Text(
                AppStrings.signInSubTitle,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.textSecondary,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 40),

              // Fields
              const AuthTextField(
                hint: AppStrings.usernameEmailLabel,
                prefixIconPath: AppAssets.user,

              ),
              const SizedBox(height: 16),
              AuthTextField(
                hint: AppStrings.passwordHint,
                prefixIconPath: AppAssets.lock,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Image.asset(
                    AppAssets.hide,
                    width: 32,
                    height: 32,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                ),
              ),

              // Forget Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    AppStrings.forgetPassword,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              // Reminder Me
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppStrings.reminderMe,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      fontFamily: 'Poppins',
                    ),
                  ),

                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: _rememberMe,
                      onChanged: (val) => setState(() => _rememberMe = val),
                      activeThumbColor: Colors.white,
                      activeTrackColor: AppColors.primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 42,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.homeScreen),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: const Text(
                    AppStrings.signInBtn,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Sign Up Link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.signupScreen),
                  child: RichText(
                    text: const TextSpan(
                      text: AppStrings.dontHaveAccount,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        TextSpan(
                          text: AppStrings.signUpLink,
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
