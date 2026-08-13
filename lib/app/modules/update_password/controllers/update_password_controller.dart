import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/erors/login_eror.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/login_usecase.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/update_password_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class UpdatePasswordController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final GetUserOnceUsecase getUser;
  final LoginUsecase login;
  final UpdatePasswordUsecase updatePassword;
  UpdatePasswordController(
    this.getUid,
    this.getUser,
    this.updatePassword,
    this.login,
  );

  late TextEditingController oldPassword;
  late TextEditingController newPassword;
  late TextEditingController confirmPassword;

  RxBool isOldPasswordObs = true.obs;
  RxBool isNewPasswordObs = true.obs;
  RxBool isConfirmPasswordObs = true.obs;
  late String uId = '';
  var dataUser = Rxn<DataUserEntity>();
  RxBool pageLoading = false.obs;
  RxBool buttonLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
    confirmPassword = TextEditingController();
    uId = getUid();
    callGetUser(uId);
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  Future<void> callGetUser(String uId) async {
    try {
      pageLoading.value = true;
      final data = await getUser(uId);
      dataUser.value = data!;
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan :$e');
    } finally {
      pageLoading.value = false;
    }
  }

  Future<void> callUpdatePassword(
    String email,
    String oldPassword,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      buttonLoading.value = true;
      if (email.trim().isEmpty ||
          oldPassword.trim().isEmpty ||
          newPassword.trim().isEmpty ||
          confirmPassword.trim().isEmpty) {
        SnackBarHelper.warning('Harap mengisi semua data');
        return;
      }
      if (newPassword.length < 6 || confirmPassword.length < 6) {
        SnackBarHelper.warning('Password minimal 6 karakter');
        return;
      }
      if (newPassword.trim() != confirmPassword.trim()) {
        SnackBarHelper.warning('Password tidak sesuai, harap periksa kembali');
        return;
      }

      final data = await login(email, oldPassword);
      if (data != null) {
        await updatePassword(newPassword);
        SnackBarHelper.success('Berhasil mengubah password');
        Get.offAllNamed(Routes.MAIN);
      } else {
        SnackBarHelper.error('Terjadi kesalahan, Password tidak sesuai');
      }
    } on FirebaseAuthException catch (e) {
      LoginEror().handleLoginError(e);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan : $e');
    } finally {
      buttonLoading.value = false;
    }
  }
}
