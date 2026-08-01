import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget buildButtonAll(VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Text('lihat semua..', style: AppTextStyle.button2),
  );
}
