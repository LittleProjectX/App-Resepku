import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/erors/register_eror.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/register_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  final RegisterUsecase register;

  RegisterController(this.register);

  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  RxBool isPasswordObs = true.obs;
  RxBool isConfirmPasswordObs = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void clearFields() {
    email.clear();
    password.clear();
    confirmPassword.clear();
  }

  Future<void> callRegister(
    String email,
    String password,
    String repeatPassword,
  ) async {
    try {
      isLoading.value = true;
      if (email.trim().isEmpty ||
          password.trim().isEmpty ||
          repeatPassword.trim().isEmpty) {
        SnackBarHelper.cautionSnacbar(
          'Mohon untuk mengisi seluruh data dengan benar',
        );
        return;
      }

      if (password.trim().length < 6) {
        SnackBarHelper.warning('Password minimal 6 karakter');
        return;
      }

      if (password.trim().toString() != repeatPassword.trim().toString()) {
        SnackBarHelper.cautionSnacbar(
          'Password tidak sesuai, mohon periksa kembali',
        );
        return;
      }

      await register.call(email.trim(), password.trim());
      SnackBarHelper.success(
        'Silahkan cek email anda untuk melakukan verifikasi',
      );
      clearFields();
    } on FirebaseAuthException catch (e) {
      RegisterEror().handleRegisterError(e);
    } catch (_) {
      SnackBarHelper.error('Terjadi kesalahan');
    } finally {
      isLoading.value = false;
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
