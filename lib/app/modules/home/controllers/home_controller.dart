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
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/getuser_bylistid_usecase.dart';

class HomeController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final GetUserOnceUsecase getUser;
  final GetAllResepUsecase getAllResep;
  final GetAllUserUsecase getAllUser;
  final GetMyNotificationUsecase getMyNotification;
  final GetuserBylistidUsecase getUserbyListId;
  HomeController(
    this.getUid,
    this.getUser,
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
  var user = Rxn<DataUserEntity>();
  var listUser = <DataUserEntity>[].obs;
  var listUserId = <String>[].obs;
  var listFilterUser = <DataUserEntity>[].obs;
  var listFavorite = <DataFavoriteModel>[].obs;
  var listNotification = <DataNotificationModel>[].obs;
  RxBool isLike = true.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    super.onInit();
    search = TextEditingController();
    final uId = getUid.call();
    fetchGetUser(uId);
    await fetchGetAllResep();
    await fetchGetAllUser();
    await fetchGetMyNotification(uId);
  }

  @override
  void onClose() {
    search.dispose();
    super.onClose();
  }

  void clearSearch() {
    search.clear();
    currenctFocus.unfocus();
  }

  Future<void> fetchGetUser(String uId) async {
    try {
      DataUserModel? result = await getUser(uId);
      user.value = result!;
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan');
    }
  }

  Future<void> fetchGetMyNotification(String uId) async {
    try {
      isPageLoading.value = true;
      final dataNotification = await getMyNotification(uId);
      listNotification.value = dataNotification.map((e) {
        return DataNotificationModel.fromFirebase(e);
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
          return DataResepModel.fromFirebase(e);
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
          return DataUserModel.fromFirebase(e);
        }).toList();
        if (listUser.isNotEmpty) {
          listUserId.value = listResep.map((element) => element.uId).toList();
          if (listUser.isNotEmpty) {
            final filterUser = await getUserbyListId.call(listUserId);
            listFilterUser.value = filterUser.map((e) {
              return DataUserModel.fromFirebase(e);
            }).toList();
          }
        }
      } else {
        SnackBarHelper.warning('Tidak ada resep yang ditemukan.');
      }
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data author($e)');
    } finally {
      isPageLoading.value = false;
    }
  }
}
