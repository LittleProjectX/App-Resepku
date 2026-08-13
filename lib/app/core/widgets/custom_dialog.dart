import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String textConfirm;
  final String textCancel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.textConfirm,
    required this.onConfirm,
    required this.textCancel,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.inversePrimary.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.help_outline,
                size: 40,
                color: AppColors.warning,
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyle.label1,
            ),

            const SizedBox(height: 12),

            // 🔹 Content
            Text(
              content,
              textAlign: TextAlign.center,
              style: AppTextStyle.body1,
            ),

            const SizedBox(height: 24),

            // 🔹 Buttons
            Row(
              children: [
                // Cancel
                Expanded(
                  child: OutlinedButton(
                    onPressed: onCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(textCancel.tr, style: AppTextStyle.body3),
                  ),
                ),

                const SizedBox(width: 12),

                // Confirm
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: AppColors.primary,
                    ),
                    child: Text(textConfirm.tr, style: AppTextStyle.body5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
