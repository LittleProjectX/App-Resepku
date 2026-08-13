import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_notification_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/getuser_bylistid_usecase.dart';

class HomeController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final GetAllResepUsecase getAllResep;
  final GetAllUserUsecase getAllUser;
  final GetMyNotificationUsecase getMyNotification;
  final GetuserBylistidUsecase getUserbyListId;
  HomeController(
    this.getUid,
    this.getAllResep,
    this.getAllUser,
    this.getMyNotification,
    this.getUserbyListId,
  );

  late TextEditingController search;
  RxBool isPageLoading = false.obs;
  RxString currentCategory = 'Semua'.obs;
  FocusNode currenctFocus = FocusNode();
  var listResep = <DataResepEntity>[].obs;
  var listUser = <DataUserEntity>[].obs;
  var listUserId = <String>[].obs;
  var listFilterUser = <DataUserEntity>[].obs;
  var listFavorite = <DataFavoriteModel>[].obs;
  var listNotification = <DataNotificationModel>[].obs;
  RxBool isLike = true.obs;

  @override
  void onInit() async {
    super.onInit();
    search = TextEditingController();
    final uId = getUid.call();
    await fetchGetAllResep();
    await fetchGetAllUser();
    await fetchGetMyNotification(uId);
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  void clearSearch() {
    search.clear();
    currenctFocus.unfocus();
  }

  Future<void> fetchGetMyNotification(String uId) async {
    try {
      isPageLoading.value = true;
      final dataNotification = await getMyNotification(uId);
      listNotification.value = dataNotification.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return DataNotificationModel.fromFirebase(data);
      }).toList();
    } catch (e) {
      SnackBarHelper.warning('Terjadi Kesalahan ($e)');
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<void> fetchGetAllResep() async {
    try {
      isPageLoading.value = true;
      final result = await getAllResep();
      if (result.isNotEmpty) {
        listResep.value = result.map((e) {
          final data = e.data() as Map<String, dynamic>;
          return DataResepModel.fromFirebase(data);
        }).toList();
      } else {
        SnackBarHelper.warning('Tidak ada resep yang ditemukan.');
      }
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data resep : $e');
    } finally {
      isPageLoading.value = false;
    }
  }

  Future<void> fetchGetAllUser() async {
    try {
      isPageLoading.value = true;
      final result = await getAllUser();
      if (result.isNotEmpty) {
        listUser.value = result.map((e) {
          final data = e.data() as Map<String, dynamic>;
          return DataUserModel.fromFirebase(data);
        }).toList();
        if (listUser.isNotEmpty) {
          listUserId.value = listResep.map((element) => element.uId).toList();
          if (listUser.isNotEmpty) {
            final filterUser = await getUserbyListId.call(listUserId);
            listFilterUser.value = filterUser.map((e) {
              final data = e.data() as Map<String, dynamic>;
              return DataUserModel.fromFirebase(data);
            }).toList();
          }
        }
      } else {
        SnackBarHelper.warning('Tidak ada resep yang ditemukan.');
      }
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data ALLUSER($e)');
    } finally {
      isPageLoading.value = false;
    }
  }
}
