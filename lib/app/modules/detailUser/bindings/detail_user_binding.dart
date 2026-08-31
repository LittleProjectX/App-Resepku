import 'package:get/get.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/delete_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import '../controllers/detail_user_controller.dart';

class DetailUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailUserController>(
      () => DetailUserController(
        Get.find<GetUserOnceUsecase>(),
        Get.find<GetCurrentUidUsecase>(),
        Get.find<GetMyResepUsecase>(),
        Get.find<DeleteResepUsecase>(),
      ),
    );
  }
}
