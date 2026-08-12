import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:seleraku/app/core/utils/snacbar_helper.dart';
import 'package:seleraku/app/domain/models/auth_user_model.dart';
import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_stream_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';
import 'package:seleraku/app/routes/app_pages.dart';

class AuthGateController extends GetxController {
  final FirebaseAuth auth;
  final GetStreamUsecase getStream;
  final GetuserUsecase getUser;
  final IsConnectedUsecase isConnection;

  AuthGateController(
    this.auth,
    this.getStream,
    this.getUser,
    this.isConnection,
  );
  late StreamSubscription subscription;

  @override
  void onInit() {
    super.onInit();
    subscription = InternetConnection().onStatusChange.listen((status) {
      switch (status) {
        case InternetStatus.connected:
          break;

        case InternetStatus.disconnected:
          SnackBarHelper.warning('Anda tidak terhubung ke internet');
          break;
      }
    });

    getStream.call().listen((user) async {
      if (user == null) {
        Get.offAllNamed(Routes.STARTED);
      } else {
        if (!user.emailVerified) {
          Get.offAllNamed(Routes.LOGIN);
        } else {
          final userStream = getUser.call(user.uid);
          userStream.listen((snapshot) {
            if (!snapshot.exists) {
              Get.offAllNamed(Routes.FIRST_USER_DATA);
              return;
            }
            final data = snapshot.data() as Map<String, dynamic>;
            final dataUser = DataUserModel.fromFirebase(data);
            if (dataUser.isProfileComplete == true) {
              Get.offAllNamed(Routes.MAIN);
            } else {
              Get.offAllNamed(Routes.FIRST_USER_DATA);
            }
          });
        }
      }
    });
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
  }
}
