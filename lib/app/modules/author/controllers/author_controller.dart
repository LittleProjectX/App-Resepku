import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/dislike_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_author_fav_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/like_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';

class AuthorController extends GetxController {
  final FirebaseAuth auth;
  final GetuserUsecase getUser;
  final GetMyResepUsecase getResep;
  final GetAuthorFavUsecase isAuthorFav;
  final LikeAuthorUsecase likeAuthor;
  final DislikeAuthorUsecase unLikeAuthor;
  final SendNotificationUsecase sendNotification;
  AuthorController(
    this.auth,
    this.getUser,
    this.getResep,
    this.isAuthorFav,
    this.likeAuthor,
    this.unLikeAuthor,
    this.sendNotification,
  );

  StreamSubscription? _streamSubscription;
  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>> _streamLike;
  final isLoading = false.obs;
  final isAuthorLike = false.obs;
  var userData = Rxn<DataUserEntity>();
  var listResep = <DataResepEntity>[].obs;
  late String aId = '';
  late String afId = '';
  late String uId = '';

  @override
  void onInit() {
    super.onInit();
    afId = Get.parameters['uId'].toString();
    uId = auth.currentUser!.uid;
    fetchIsAuthorLike(uId, afId);
    fetchUserData(afId);
    fetchResepData(afId);
  }

  @override
  void onClose() {
    _streamLike.cancel();
    super.onClose();
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

  Future<void> fetchResepData(String uId) async {
    try {
      isLoading.value = true;
      Stream<List<QueryDocumentSnapshot<Object?>>> dataRaw = getResep.call(uId);

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

  void fetchIsAuthorLike(String uId, String afId) {
    try {
      isLoading.value = true;
      _streamLike = isAuthorFav.call(uId, afId).listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          aId = snapshot.docs.first.id;
        }
        isAuthorLike.value = snapshot.docs.isNotEmpty;
      });
    } catch (e) {
      SnackBarHelper.warning('Terjadi kesalahan ($e)');
    } finally {
      isLoading.value = false;
    }
  }

  void fetchLikeAuthor(
    String uId,
    String afId,
    int likes,
    String imageUrl,
    String title,
    String msg,
  ) {
    try {
      likeAuthor(uId, afId, likes);
      final List<String> receiverId = [];
      receiverId.add(afId);
      final bool isRead = false;

      sendNotification(
        uId,
        receiverId,
        imageUrl,
        title,
        msg,
        isRead,
        Timestamp.now(),
      );
    } catch (e) {
      SnackBarHelper.error('Gagal menyukai resep ($e)');
    }
  }

  void fetchUnLikeAuthor(String afId, String aId, int likes) {
    try {
      unLikeAuthor(afId, aId, likes);
    } catch (e) {
      SnackBarHelper.error('Terjadi kesalahan ($e)');
    }
  }
}
