import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildListTileProfile(
  IconData icon,
  String title,
  String subtitle,
  VoidCallback onTap,
) {
  return ListTile(
    leading: Icon(icon),
    trailing: Icon(
      Iconsax.arrow_right_3_copy,
      size: 16,
      color: AppColors.textSecondary,
    ),
    title: Text(title, style: AppTextStyle.body2),
    subtitle: Text(subtitle, style: AppTextStyle.body6),
    tileColor: AppColors.surface,
    onTap: onTap,
  );
}
