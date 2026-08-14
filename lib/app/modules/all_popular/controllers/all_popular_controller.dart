import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';

class AllPopularController extends GetxController {
  final GetAllResepUsecase getAllResep;
  AllPopularController(this.getAllResep);

  var listAllResep = <DataResepEntity>[].obs;
  RxString type = ''.obs;
  RxBool isPageLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    type.value = Get.parameters['type'].toString();
    fetchAllResep();
  }

  Future<void> fetchAllResep() async {
    try {
      isPageLoading.value = true;
      final result = await getAllResep();
      listAllResep.value = result.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return DataResepModel.fromFirebase(data);
      }).toList();
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan : $e');
    } finally {
      isPageLoading.value = false;
    }
  }
}
