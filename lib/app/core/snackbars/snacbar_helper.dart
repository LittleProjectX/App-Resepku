import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:seleraku/app/core/theme/text_theme.dart';

class SnackBarHelper {
  static void success(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Sukses', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(
        Icons.check,
        color: Colors.green, // Warna khas warning
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.green,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      duration: const Duration(seconds: 3),
    );
  }

  static void error(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Eror', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(
        Icons.error,
        color: Colors.red, // Warna khas warning
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.red,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      duration: const Duration(seconds: 3),
    );
  }

  static void warning(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Peringatan', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(
        Icons.report_problem_rounded,
        color: Colors.amber, // Warna khas warning
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.amber,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      duration: const Duration(seconds: 3),
    );
  }

  static void info(String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text('Info', style: AppTextStyle.heading4),
      messageText: Text(message, style: AppTextStyle.body2),
      icon: const Icon(
        Icons.info,
        color: Colors.blue, // Warna khas warning
        size: 28,
      ),
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      backgroundColor: Colors.white,
      leftBarIndicatorColor: Colors.blue,
      boxShadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.6),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
      duration: const Duration(seconds: 3),
    );
  }
}
