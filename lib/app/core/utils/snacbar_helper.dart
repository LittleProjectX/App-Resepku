import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/color_theme.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class SnackBarHelper {
  static void cautionSnacbar(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Perhatian', style: AppTextStyle.label1),
      messageText: Text(message, style: AppTextStyle.body3),
      icon: const Icon(Icons.warning, color: AppColors.textPrimary),
      backgroundColor: AppColors.surface,
    );
  }

  static void success(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Sukses', style: AppTextStyle.label1),
      messageText: Text(message, style: AppTextStyle.body3),
      icon: const Icon(Icons.check_circle, color: AppColors.textPrimary),
      backgroundColor: AppColors.surface,
    );
  }

  static void error(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Eror', style: AppTextStyle.label1),
      messageText: Text(message, style: AppTextStyle.body3),
      icon: const Icon(Icons.error, color: AppColors.textPrimary),
      backgroundColor: AppColors.surface,
    );
  }

  static void warning(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Peringatan', style: AppTextStyle.label1),
      messageText: Text(message, style: AppTextStyle.body3),
      icon: const Icon(Icons.warning, color: AppColors.textPrimary),
      backgroundColor: AppColors.surface,
    );
  }

  static void info(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Info', style: AppTextStyle.label1),
      messageText: Text(message, style: AppTextStyle.body3),
      icon: const Icon(Icons.info, color: AppColors.textPrimary),
      backgroundColor: AppColors.surface,
    );
  }
}
