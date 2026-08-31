import 'package:get/get.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/getuser_bylistid_usecase.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        Get.find<GetCurrentUidUsecase>(),
        Get.find<GetUserOnceUsecase>(),
        Get.find<GetAllResepUsecase>(),
        Get.find<GetAllUserUsecase>(),
        Get.find<GetMyNotificationUsecase>(),
        Get.find<GetuserBylistidUsecase>(),
      ),
    );
  }
}
