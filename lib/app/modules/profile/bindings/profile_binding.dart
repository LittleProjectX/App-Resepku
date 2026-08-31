import 'package:get/get.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/logout_usecase.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(Get.find<LogoutUsecase>()),
    );
  }
}
