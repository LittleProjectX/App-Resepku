import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildLargeButton({
  required String label,
  Color color = AppColors.primary,
  bool isLoading = false,
  required VoidCallback onTap,
}) {
  return SizedBox(
    height: 54,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onTap,
      child: isLoading
          ? SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(color: AppColors.surface),
            )
          : Text(label, style: AppTextStyle.button1),
    ),
  );
}
