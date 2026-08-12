import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/reset_password_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class EditPasswordController extends GetxController {
  final ResetPasswordUsecase resetPassword;
  EditPasswordController(this.resetPassword);

  late TextEditingController email;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
  }

  @override
  void onClose() {
    email.dispose();
    super.onClose();
  }

  void clearEmail() {
    email.clear();
  }

  Future<void> resetPasswordUser(String email) async {
    if (email.isEmpty) {
      SnackBarHelper.warning('Email tidak boleh kosong');
      return;
    }

    try {
      isLoading.value = true;
      await resetPassword.call(email);
      Get.offAllNamed(Routes.WAIT_RESET_PASSWORD, parameters: {'email': email});
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan $e');
    } finally {
      isLoading.value = false;
    }
  }
}
