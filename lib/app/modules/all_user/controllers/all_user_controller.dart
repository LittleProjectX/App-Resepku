import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/getuser_bylistid_usecase.dart';

class AllUserController extends GetxController {
  final GetAllResepUsecase getAllResep;
  final GetuserBylistidUsecase getUser;

  AllUserController(this.getAllResep, this.getUser);

  var listAllUser = <DataUserEntity>[].obs;

  List<String> listUid = [];

  RxBool isPageLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();

    await fetchAllResep();
    await fetchUserbyList(listUid);
  }

  Future<void> fetchAllResep() async {
    try {
      isPageLoading.value = true;

      final result = await getAllResep();

      listUid = result
          .map((e) {
            return e.uId;
          })
          .toSet()
          .toList();
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan: $e');
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<void> fetchUserbyList(List<String> listId) async {
    try {
      isPageLoading.value = true;

      final result = await getUser(listId);

      listAllUser.value = result;
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan: $e');
    } finally {
      isPageLoading.value = false;
    }
  }
}
