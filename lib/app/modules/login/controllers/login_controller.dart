import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/erors/login_eror.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/login_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginUsecase login;
  final GetuserUsecase getUser;
  LoginController(this.login, this.getUser);

  late TextEditingController email;
  late TextEditingController password;
  RxBool isObs = true.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void clearField() {
    email.clear();
    password.clear();
  }

  Future<void> callLogin(String email, String password) async {
    try {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        SnackBarHelper.cautionSnacbar('Mohon untuk mengisi email dan password');
        return;
      }

      isLoading.value = true;

      final user = await login.call(email, password);

      clearField();

      if (user != null) {
        if (!user.isVerified) {
          SnackBarHelper.cautionSnacbar(
            'Silakan verifikasi email terlebih dahulu',
          );
          return;
        }

        final dataUser = await getUser.call(user.uId);
        if (dataUser == null) {
          SnackBarHelper.cautionSnacbar('Data tidak ditemukan');
          return;
        } else {
          final data = dataUser.isProfileComplete;
          if (data == true) {
            Get.offAllNamed(Routes.MAIN);
          }

          Get.offAllNamed(Routes.FIRST_USER_DATA);
        }
      }
    } on FirebaseAuthException catch (e) {
      LoginEror().handleLoginError(e);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan : $e');
    } finally {
      isLoading.value = false;
    }
  }
}
