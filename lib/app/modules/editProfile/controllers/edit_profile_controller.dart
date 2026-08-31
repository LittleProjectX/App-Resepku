import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/setUser_profile_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class EditProfileController extends GetxController {
  final GetUserOnceUsecase getUser;
  final GetCurrentUidUsecase getUid;
  final SetuserProfileUsecase setUserData;
  EditProfileController(this.getUser, this.getUid, this.setUserData);

  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  String uId = '';
  RxString imageUrl = ''.obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    name = TextEditingController();
    email = TextEditingController();
    phone = TextEditingController();

    uId = getUid();
    final dataUser = await getUser.call(uId);

    if (dataUser != null) {
      name.text = dataUser.name != null ? dataUser.name.toString() : '';
      email.text = (dataUser.email).toString();
      phone.text = dataUser.phone != null ? dataUser.phone.toString() : '';
      imageUrl.value = (dataUser.imageUrl ?? '').toString();
    } else {
      name.text = '';
      email.text = '';
      phone.text = '';
      imageUrl.value = '';
    }
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    phone.dispose();
    super.dispose();
  }

  Future<void> setUser(
    String uId,
    String name,
    String email,
    String phone,
  ) async {
    try {
      isLoading.value = true;
      if (name.trim().isEmpty || email.trim().isEmpty || phone.trim().isEmpty) {
        SnackBarHelper.warning('Mohon untuk tidak mengosongkan field');
        isLoading.value = false;
        return;
      }
      if (phone.trim().length < 8) {
        SnackBarHelper.error('Format telepon tidak sesuai');
        isLoading.value = false;
        return;
      }

      await setUserData.call(uId, name, email, phone);
      SnackBarHelper.success('Data berhasil disimpan');
      Get.toNamed(Routes.MAIN);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan ($e)');
    } finally {
      isLoading.value = false;
    }
  }
}
