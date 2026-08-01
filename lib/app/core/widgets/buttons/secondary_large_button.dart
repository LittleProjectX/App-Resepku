import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget secondaryLargeButton({
  required String label,
  Color color = AppColors.primary,
  bool isLoading = false,
  required VoidCallback onTap,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.surface,
        side: BorderSide(color: AppColors.primary, width: 2),
      ),
      onPressed: onTap,
      child: isLoading
          ? CircularProgressIndicator(color: AppColors.primary)
          : Text(label, style: AppTextStyle.button3),
    ),
  );
}
