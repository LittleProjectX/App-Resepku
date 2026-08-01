import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildLike(String like) {
  return Row(
    children: [
      Icon(Iconsax.heart, color: AppColors.textSecondary, size: 14),
      const SizedBox(width: 4),
      Text('$like Likes', style: AppTextStyle.body7),
    ],
  );
}
