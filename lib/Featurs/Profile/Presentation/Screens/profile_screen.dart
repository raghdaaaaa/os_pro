import 'package:brain_stack/Featurs/Profile/Presentation/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../Core/Constants/app_color.dart';
import '../../../../Core/Constants/app_strings.dart';
import '../../../../Core/Constants/assets.dart';
import '../../../../Core/Widgets/app_scaffold.dart';
import '../../../../Core/Widgets/app_loader.dart';
import '../Widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<ProfileController>().loadUserData());
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ProfileController>();

    return AppScaffold(
      currentNavIndex: 4,
      body: SafeArea(
        child: controller.isLoading
            ? const AppLoader()
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Image.asset(
                    AppAssets.profilePic,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Name من Firestore
              Text(
                controller.userData?['username'] ?? AppStrings.profileUserName,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 4),

              // Phone
              Text(
                controller.userData?['phone'] ?? AppStrings.profileUserEmail,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 37),

              ProfileMenuItem(icon: AppAssets.edit, title: AppStrings.profileEditProfile, onTap: () {}),
              const SizedBox(height: 14),
              ProfileMenuItem(icon: AppAssets.secure, title: AppStrings.profileSecurityPrivacy, onTap: () {}),
              const SizedBox(height: 14),
              ProfileMenuItem(icon: AppAssets.theme, title: AppStrings.profileAppTheme, trailingLabel: AppStrings.profileThemeLight, onTap: () {}),
              const SizedBox(height: 14),
              ProfileMenuItem(icon: AppAssets.help, title: AppStrings.profileHelpSupport, onTap: () {}),
              const SizedBox(height: 40),

              // Logout
              SizedBox(
                width: 340,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () => controller.logout(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  icon: Image.asset(AppAssets.logout, width: 20, height: 20, color: AppColors.white),
                  label: const Text(
                    AppStrings.profileLogout,
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.white),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}