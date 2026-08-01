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
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onTap,
      child: isLoading
          ? CircularProgressIndicator(color: AppColors.surface)
          : Text(label, style: AppTextStyle.button1),
    ),
  );
}
