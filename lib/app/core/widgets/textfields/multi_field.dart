import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildMultiField({
  required String hintText,
  int maxLines = 15,
  int minLines = 8,
  required TextEditingController controller,
}) {
  return TextField(
    style: AppTextStyle.body2,
    keyboardType: TextInputType.multiline,
    controller: controller,
    minLines: minLines,
    maxLines: maxLines,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      hintStyle: AppTextStyle.body1,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: AppColors.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
    ),
  );
}
