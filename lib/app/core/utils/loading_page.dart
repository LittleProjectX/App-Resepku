import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';

Widget loadingPage({Color color = AppColors.textPrimary}) {
  return Center(child: CircularProgressIndicator(color: color, strokeWidth: 2));
}
