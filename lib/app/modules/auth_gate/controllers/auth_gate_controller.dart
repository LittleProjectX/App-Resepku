import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:seleraku/app/core/snackbars/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_stream_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class AuthGateController extends GetxController {
  final GetStreamUsecase getStream;
  final GetuserUsecase getUser;
  final IsConnectedUsecase isConnection;

  AuthGateController(this.getStream, this.getUser, this.isConnection);

  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userSubscription;
  StreamSubscription<InternetStatus>? _connectionSubscription;

  @override
  void onInit() {
    super.onInit();
    _listenConnection();
    _listenAuth();
  }

  void _listenConnection() {
    _connectionSubscription = InternetConnection().onStatusChange.listen((
      status,
    ) {
      switch (status) {
        case InternetStatus.connected:
          break;

        case InternetStatus.disconnected:
          SnackBarHelper.warning('Anda tidak terhubung ke internet');
          break;
      }
    });
  }

  void _listenAuth() {
    _authSubscription = getStream.call().listen(
      (user) {
        _handleAuthState(user);
      },
      onError: (error) {
        SnackBarHelper.error('Terjadi kesalahan autentikasi');
      },
    );
  }

  void _handleAuthState(User? user) {
    _userSubscription?.cancel();
    _userSubscription = null;

    if (user == null) {
      Get.offAllNamed(Routes.STARTED);
      return;
    }

    if (!user.emailVerified) {
      Get.offAllNamed(Routes.CONFIRM_EMAIL_REGIS);
      return;
    }

    _listenUserData(user.uid);
  }

  void _listenUserData(String uid) {
    _userSubscription = getUser.call(uid).listen((snapshot) {
      if (!snapshot.exists) {
        Get.offAllNamed(Routes.FIRST_USER_DATA);
        return;
      }

      final data = snapshot.data();

      if (data == null) {
        Get.offAllNamed(Routes.FIRST_USER_DATA);
        return;
      }

      final dataUser = DataUserModel.fromFirebase(data);

      if (dataUser.isProfileComplete) {
        Get.offAllNamed(Routes.MAIN);
      } else {
        Get.offAllNamed(Routes.FIRST_USER_DATA);
      }
    });
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    _userSubscription?.cancel();
    _connectionSubscription?.cancel();

    super.onClose();
  }
}
