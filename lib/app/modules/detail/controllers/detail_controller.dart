import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/dislike_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_like_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_resep_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_save_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/like_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/save_to_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/unsave_resep_usecase.dart';

class DetailController extends GetxController {
  final GetCurrentUidUsecase getUid;
  final GetResepByidUsecase getResep;
  final GetUserOnceUsecase getAuthor;
  final GetSaveByidUsecase isSave;
  final GetLikeByidUsecase isLike;
  final SaveToMyResepUsecase saveResep;
  final UnsaveResepUsecase unSaveResep;
  final LikeResepUsecase likeResep;
  final DislikeResepUsecase disLikeResep;
  final SendNotificationUsecase sendNotification;
  DetailController(
    this.getUid,
    this.getResep,
    this.getAuthor,
    this.isSave,
    this.isLike,
    this.saveResep,
    this.unSaveResep,
    this.likeResep,
    this.disLikeResep,
    this.sendNotification,
  );
  late String rId = '';
  late String uId = '';
  late String saveId = '';
  late String likeId = '';
  var dataResep = Rxn<DataResepEntity>();
  var dataAuthor = Rxn<DataUserEntity>();
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _saveStream;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _likeStream;
  RxBool isLoading = false.obs;
  final isResepSave = false.obs;
  final isResepLike = false.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    rId = Get.parameters['rId'].toString();
    uId = getUid();
    fetchDataResep(rId);
    fetchIsSave(uId, rId);
    fetchIsLike(uId, rId);
    isLoading.value = false;
  }

  @override
  void onClose() {
    _saveStream.cancel();
    _likeStream.cancel();
    super.onClose();
  }

  Future<void> fetchDataResep(String rId) async {
    try {
      isLoading.value = true;
      DataResepEntity? resep = await getResep.call(rId);
      dataResep.value = resep;
      DataUserEntity? author = await getAuthor.call(resep.uId);
      dataAuthor.value = author;
      isLoading.value = false;
    } catch (e) {
      SnackBarHelper.error('Gagal mengambil data ($e)');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchIsSave(String uId, String rId) {
    try {
      isLoading.value = true;
      _saveStream = isSave
          .call(uId, rId)
          .listen(
            (snapshot) {
              if (snapshot.docs.isNotEmpty) {
                saveId = snapshot.docs.first.id;
              }
              isResepSave.value = snapshot.docs.isNotEmpty;
              isLoading.value = false;
            },
            onError: (e) {
              isLoading.value = false;
              SnackBarHelper.warning('Terjadi kesalahan ($e)');
            },
          );
    } catch (e) {
      SnackBarHelper.warning('Terjadi kesahalahan ($e)');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchIsLike(String uId, String rId) {
    try {
      isLoading.value = true;
      _likeStream = isLike
          .call(uId, rId)
          .listen(
            (snapshot) {
              if (snapshot.docs.isNotEmpty) {
                likeId = snapshot.docs.first.id;
              }
              isResepLike.value = snapshot.docs.isNotEmpty;
              isLoading.value = false;
            },
            onError: (e) {
              isLoading.value = false;
              SnackBarHelper.warning('Terjadi kesalahan ($e)');
            },
          );
    } catch (e) {
      SnackBarHelper.warning('Terjadi kesalahan ($e)');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchSaveResep(String uId, String rId, int saves) {
    try {
      saveResep.call(uId, rId, saves);
    } catch (e) {
      SnackBarHelper.error('Gagal menyimpan resep ($e)');
    }
  }

  void fetchUnsaveResep(String fId, String rId, int saves) {
    try {
      unSaveResep(fId, rId, saves);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan ($e)');
    }
  }

  void fetchLikeResep(
    String uId,
    String rId,
    int likes,
    List<String> receiverId,
    String imageUrl,
    String title,
    String msg,
  ) {
    try {
      final bool isRead = false;

      likeResep(uId, rId, likes);

      sendNotification(
        uId,
        receiverId,
        imageUrl,
        title,
        msg,
        isRead,
        DateTime.now(),
      );
    } catch (e) {
      SnackBarHelper.error('Gagal menyukai resep ($e)');
    }
  }

  void fetchUnLikeResep(String uId, String fId, String rId, int likes) {
    try {
      disLikeResep(fId, likes, rId);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan ($e)');
    }
  }
}
