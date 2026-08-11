import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';

Widget buttonCircle({
  double left = 32,
  Color color = AppColors.textPrimary,
  required VoidCallback onTap,
  required IconData icon,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(left: left),
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 20),
    ),
  );
}
