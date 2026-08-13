import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildButtonAddResep(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: SizedBox(
      width: 120,
      height: 42,
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(24),
        child: Center(child: Text('Tambah +', style: AppTextStyle.button1)),
      ),
    ),
  );
}
