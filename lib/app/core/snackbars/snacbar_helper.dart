import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class SnackBarHelper {
  static void cautionSnacbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Perhatian', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(Icons.warning, color: AppColors.textPrimary),
      backgroundGradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        colors: [AppColors.primary, Color(0xffaebaf8)],
      ),

      duration: const Duration(seconds: 3),
      barBlur: 10,
    );
  }

  static void success(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Sukses', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(Icons.check_circle, color: AppColors.textPrimary),
      backgroundGradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        colors: [AppColors.primary, Color(0xffaebaf8)],
      ),

      duration: const Duration(seconds: 3),
      barBlur: 10,
    );
  }

  static void error(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Eror', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(Icons.error, color: AppColors.textPrimary),
      backgroundGradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        colors: [AppColors.primary, Color(0xffaebaf8)],
      ),

      duration: const Duration(seconds: 3),
      barBlur: 10,
    );
  }

  static void warning(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Peringatan', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(Icons.warning, color: AppColors.textPrimary),
      backgroundGradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        colors: [AppColors.primary, Color(0xffaebaf8)],
      ),

      duration: const Duration(seconds: 3),
      barBlur: 10,
    );
  }

  static void info(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Info', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(Icons.info, color: AppColors.textPrimary),
      backgroundGradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        colors: [AppColors.primary, Color(0xffaebaf8)],
      ),

      duration: const Duration(seconds: 3),
      barBlur: 10,
    );
  }
}
