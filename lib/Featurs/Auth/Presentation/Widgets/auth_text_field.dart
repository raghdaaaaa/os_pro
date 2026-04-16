import 'package:flutter/material.dart';
import '../../../../Core/Constants/app_color.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final String? prefixIconPath;
  final IconData? prefixIconData;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const AuthTextField({
    super.key,
    required this.hint,
    this.prefixIconPath,
    this.prefixIconData,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.accentBeige,
        borderRadius: BorderRadius.circular(35),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(15.0),
            child: prefixIconPath != null 
                ? Image.asset(prefixIconPath!, width: 17, height: 17)
                : Icon(prefixIconData, color: AppColors.textPrimary, size: 20),
          ),
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: const TextStyle(
            color: AppColors.textSecondary,
            fontFamily: 'Poppins',
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
