import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';

class AllResepController extends GetxController {
  final GetAllResepUsecase getAllResep;
  AllResepController(this.getAllResep);

  RxString category = ''.obs;
  var listAllResep = <DataResepModel>[].obs;
  RxBool isPageLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    category.value = Get.parameters['category'].toString();
    fetchAllResep();
  }

  Future<void> fetchAllResep() async {
    try {
      isPageLoading.value = true;
      final result = await getAllResep();
      listAllResep.value = result.map((e) {
        return DataResepModel.fromFirebase(e);
      }).toList();
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan : $e');
    } finally {
      isPageLoading.value = false;
    }
  }
}
