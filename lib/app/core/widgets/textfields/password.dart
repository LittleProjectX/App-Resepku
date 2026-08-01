import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildPasswordField({
  required String hintText,
  required VoidCallback eyeTap,
  required bool isObs,
  int maxLines = 1,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: TextField(
      style: AppTextStyle.body2,
      keyboardType: TextInputType.text,

      maxLines: isObs ? 1 : maxLines,
      obscureText: isObs,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: AppTextStyle.body1,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),

        suffixIcon: IconButton(
          onPressed: eyeTap,
          icon: Icon(
            isObs ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            size: 20,
            color: Colors.grey,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.border),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    ),
  );
}
