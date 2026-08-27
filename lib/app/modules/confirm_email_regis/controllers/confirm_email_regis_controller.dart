import 'dart:async';

import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/resend_verification_email_usecase.dart';

class ConfirmEmailRegisController extends GetxController {
  final ResendVerificationEmailUsecase resendEmailVerification;
  ConfirmEmailRegisController(this.resendEmailVerification);

  RxString email = ''.obs;
  RxBool isLoading = false.obs;
  RxInt remainingSeconds = 150.obs;
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
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

  void resendEmail() {
    try {
      resendEmailVerification();
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
