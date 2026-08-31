import 'package:get/get.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_saved_resep_bylistid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_saved_resep_usecase.dart';

import '../controllers/save_resep_controller.dart';

class SaveResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaveResepController>(
      () => SaveResepController(
        Get.find<GetCurrentUidUsecase>(),
        Get.find<GetSavedResepUsecase>(),
        Get.find<GetSavedResepBylistidUsecase>(),
      ),
    );
  }
}
