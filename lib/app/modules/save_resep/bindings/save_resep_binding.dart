import 'package:get/get.dart';

import '../controllers/save_resep_controller.dart';

class SaveResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaveResepController>(
      () => SaveResepController(Get.find(), Get.find(), Get.find()),
    );
  }
}
