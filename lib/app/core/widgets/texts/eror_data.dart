import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

Widget errorData({String text = 'Data tidak ditemukan'}) {
  return Center(child: Text(text, style: AppTextStyle.body2));
}
