import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class BuildButtonAll extends StatelessWidget {
  const BuildButtonAll({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text('Semua', style: AppTextStyle.button3),
    );
  }
}
