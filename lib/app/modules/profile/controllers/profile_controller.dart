import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/core/widgets/custom_dialog.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/logout_usecase.dart';

class ProfileController extends GetxController {
  final LogoutUsecase logOutUsecase;
  ProfileController(this.logOutUsecase);

  Future<void> logout() async {
    try {
      Get.dialog(
        CustomDialog(
          title: 'keluar',
          content: 'Apakah anda yakin keluar dari akun ini?',
          textConfirm: 'Yakin',
          onConfirm: () async {
            await logOutUsecase();
          },
          textCancel: 'Tidak',
          onCancel: () => Get.back(),
        ),
      );
    } catch (e) {
      SnackBarHelper.warning(
        'Gagal Logout, Terjadi kesalahan saat logout. Silakan coba lagi.',
      );
    }
  }
}
