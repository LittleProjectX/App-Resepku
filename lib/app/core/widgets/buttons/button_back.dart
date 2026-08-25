import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';

class ButtonCircle extends StatelessWidget {
  const ButtonCircle({
    super.key,
    this.left = 32,
    this.color = AppColors.textPrimary,
    required this.onTap,
    required this.icon,
  });

  final double left;
  final Color color;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
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
              color: Colors.black.withAlpha(30),
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
}
