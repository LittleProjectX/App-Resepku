import 'dart:async';

import 'package:get/get.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/reset_password_usecase.dart';

class WaitResetPasswordController extends GetxController {
  final ResetPasswordUsecase resetpassword;
  WaitResetPasswordController(this.resetpassword);

  RxString email = ''.obs;
  RxBool isLoading = false.obs;
  RxInt remainingSeconds = 150.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    email.value = Get.parameters['email'] ?? '';
    startCountdown();
  }

  void startCountdown() {
    isLoading.value = true;
    remainingSeconds.value = 150;

    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        isLoading.value = false;
        timer.cancel();
      }
    });
  }

  String get countdownText {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  void resetPassword(String email) {
    try {
      resetpassword(email);
      startCountdown();
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan $e');
    }
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
