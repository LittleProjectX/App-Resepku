import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/models/data_notification_model.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_notification_usecase.dart';

class HomeController extends GetxController {
  final FirebaseAuth auth;
  final GetAllResepUsecase getAllResep;
  final GetAllUserUsecase getAllUser;
  final GetMyNotificationUsecase getMyNotification;
  HomeController(
    this.auth,
    this.getAllResep,
    this.getAllUser,
    this.getMyNotification,
  );

  late TextEditingController search;
  RxString currentCategory = 'Semua'.obs;
  FocusNode currenctFocus = FocusNode();
  var listResep = <DataResepEntity>[].obs;
  var listUser = <DataUserEntity>[].obs;
  var listFavorite = <DataFavoriteModel>[].obs;
  var listNotification = <DataNotificationModel>[].obs;
  RxBool isLike = true.obs;

  @override
  void onInit() {
    super.onInit();
    search = TextEditingController();
    fetchGetAllResep();
    fetchGetAllUser();
    fetchGetMyNotification(auth.currentUser!.uid);
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
      final dataNotification = await getMyNotification(uId);
      listNotification.value = dataNotification.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return DataNotificationModel.fromFirebase(data);
      }).toList();
    } catch (e) {
      SnackBarHelper.warning('Terjadi Kesalahan ($e)');
    }
  }

  Future<void> fetchGetAllResep() async {
    try {
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
      SnackBarHelper.error('Gagal mengambil data resep ($e)');
    }
  }

  Future<void> fetchGetAllUser() async {
    try {
      final result = await getAllUser();
      if (result.isNotEmpty) {
        listUser.value = result.map((e) {
          final data = e.data() as Map<String, dynamic>;
          return DataUserModel.fromFirebase(data);
        }).toList();
      } else {
        SnackBarHelper.warning('Tidak ada resep yang ditemukan.');
      }
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data ($e)');
    }
  }
}
