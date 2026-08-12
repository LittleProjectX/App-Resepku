import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';
import 'package:seleraku/app/core/widgets/custom_dialog.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/delete_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';

class DetailUserController extends GetxController {
  late GetUserOnceUsecase getUser;
  late GetCurrentUidUsecase currentUid;
  late GetMyResepUsecase getMyResep;
  late DeleteResepUsecase deleteResep;
  DetailUserController(
    this.getUser,
    this.currentUid,
    this.getMyResep,
    this.deleteResep,
  );
  late String uId = '';
  var userData = Rxn<DataUserEntity>();
  var listResep = <DataResepEntity>[].obs;
  RxBool isLoading = false.obs;
  StreamSubscription? _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    uId = currentUid.call();
    fetchUserData(uId);
    fetchResepData();
  }

  Future<void> fetchUserData(String uId) async {
    try {
      isLoading.value = true;
      DataUserEntity? user = await getUser.call(uId);
      userData.value = user!;
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data ($e)');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchResepData() async {
    try {
      isLoading.value = true;
      Stream<List<QueryDocumentSnapshot<Object?>>> dataRaw = getMyResep.call(
        uId,
      );

      await _streamSubscription?.cancel();
      _streamSubscription = dataRaw.listen((listDoc) {
        listResep.value = listDoc.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return DataResepModel.fromFirebase(data);
        }).toList();
      });
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data ($e)');
      isLoading.value = false;
    }
  }

  Future<void> fetchDeleteResep(String rId) async {
    try {
      Get.dialog(
        CustomDialog(
          title: 'Hapus Resep',
          content: 'Apakah anda yakin ingin menghapus data ini?',
          textConfirm: 'Yakin',
          onConfirm: () async {
            await deleteResep.call(rId);
            Get.back();
          },
          textCancel: 'Tidak',
          onCancel: () => Get.back(),
        ),
      );
    } catch (e) {
      SnackBarHelper.error('Gagal menghapus data');
    }
  }
}
