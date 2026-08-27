import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/erors/login_eror.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/login_with_google_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/login_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final LoginUsecase login;
  final GetuserUsecase getUser;
  final LoginWithGoogleUsecase loginWithGoogle;
  LoginController(this.login, this.getUser, this.loginWithGoogle);

  late TextEditingController email;
  late TextEditingController password;
  RxBool isObs = true.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void onClose() {
    FocusManager.instance.primaryFocus?.unfocus();
    email.dispose();
    password.dispose();
    super.onClose();
  }

  void clearField() {
    email.clear();
    password.clear();
  }

  Future<void> callLogin(String email, String password) async {
    try {
      isLoading.value = true;
      if (email.trim().isEmpty || password.trim().isEmpty) {
        SnackBarHelper.warning('Mohon untuk mengisi email dan password');
        return;
      }

      final user = await login.call(email, password);

      if (user != null) {
        if (!user.isVerified) {
          SnackBarHelper.warning('Silakan verifikasi email terlebih dahulu');
          return;
        }

        final dataUser = getUser.call(user.uId);
        dataUser.listen((snapshot) {
          if (!snapshot.exists) {
            SnackBarHelper.warning('Data tidak ditemukan');
            return;
          }
          final dataUser = snapshot.data() as Map<String, dynamic>;
          final data = DataUserModel.fromFirebase(dataUser);
          final isComplete = data.isProfileComplete;
          if (isComplete == true) {
            Get.offAllNamed(Routes.MAIN);
          } else {
            Get.offAllNamed(Routes.FIRST_USER_DATA);
          }
        });
        // print(dataUser);
      }
    } on FirebaseAuthException catch (e) {
      LoginEror().handleLoginError(e);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan : $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> callSigninWithGoogle() async {
    try {
      isLoading.value = true;
      await loginWithGoogle();
    } on FirebaseAuthException catch (e) {
      LoginEror().handleLoginError(e);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan $e');
    } finally {
      isLoading.value = false;
    }
  }
}
