import 'package:get/get.dart';

import '../controllers/all_resep_controller.dart';

class AllResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllResepController>(
      () => AllResepController(),
    );
  }
}
