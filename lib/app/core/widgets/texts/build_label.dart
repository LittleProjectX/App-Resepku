import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildLabel(String label) {
  return Padding(
    padding: EdgeInsetsGeometry.only(bottom: 8),
    child: Text(label, style: AppTextStyle.label1),
  );
}
