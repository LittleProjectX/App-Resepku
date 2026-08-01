import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/reset_password_usecase.dart';

class EditPasswordController extends GetxController {
  final ResetPasswordUsecase resetPassword;
  EditPasswordController(this.resetPassword);

  late TextEditingController email;

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

  void resetPasswordUser(String email) async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email tidak boleh kosong');
      return;
    }

    try {
      await resetPassword.call(email);
      Get.snackbar('Sukses', 'Email reset password telah dikirim');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
