import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/erors/register_eror.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
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
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void onClose() {
    FocusManager.instance.primaryFocus?.unfocus();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  void snackHelper(String message) {
    return SnackBarHelper.warning(message);
  }

  Future<void> callRegister(
    String email,
    String password,
    String repeatPassword,
  ) async {
    try {
      isLoading.value = true;

      await register.call(email.trim(), password.trim());
      SnackBarHelper.success(
        'Silahkan cek email anda untuk melakukan verifikasi',
      );
      Get.offAllNamed(Routes.CONFIRM_EMAIL_REGIS);
    } on FirebaseAuthException catch (e) {
      RegisterEror().handleRegisterError(e);
    } catch (a) {
      SnackBarHelper.error('Terjadi kesalahan $a');
      print('ctrl $a');
    } finally {
      isLoading.value = false;
    }
  }
}
