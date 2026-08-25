import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class SecondaryLargeButton extends StatelessWidget {
  const SecondaryLargeButton({
    super.key,
    this.color = AppColors.primary,
    this.isLoading = false,
    required this.label,
    required this.onTap,
  });

  final Color color;
  final bool isLoading;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
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
}
