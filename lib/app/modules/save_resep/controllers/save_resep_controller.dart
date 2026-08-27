import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_saved_resep_bylistid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_saved_resep_usecase.dart';

class SaveResepController extends GetxController {
  final GetCurrentUidUsecase getuId;
  final GetSavedResepUsecase savedResep;
  final GetSavedResepBylistidUsecase getResepByListId;
  SaveResepController(this.getuId, this.savedResep, this.getResepByListId);
  late String uId = '';
  final isLoading = false.obs;
  var listFavorite = <DataFavoriteModel>[].obs;
  var listResep = <DataResepEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    uId = getuId();
    fetchSavedResep(uId);
  }

  Future<void> fetchSavedResep(String uId) async {
    try {
      isLoading.value = true;
      final dataFavorite = await savedResep(uId);
      listFavorite.value = dataFavorite.map((e) {
        final favorite = e.data() as Map<String, dynamic>;
        return DataFavoriteModel.fromFirebase(favorite);
      }).toList();
      if (listFavorite.isNotEmpty) {
        final listId = listFavorite.map((element) => element.rId).toList();
        final dataResep = await getResepByListId.call(listId);
        listResep.value = dataResep.map((e) {
          return DataResepModel.fromFirebase(e);
        }).toList();
      }
    } catch (e) {
      SnackBarHelper.warning('Gagal mengambil data ($e)');
    } finally {
      isLoading.value = false;
    }
  }
}
