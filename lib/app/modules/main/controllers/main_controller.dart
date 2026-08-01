import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/logout_usecase.dart';
import 'package:seleraku/app/modules/detailUser/views/detail_user_view.dart';
import 'package:seleraku/app/modules/home/views/home_view.dart';
import 'package:seleraku/app/modules/profile/views/profile_view.dart';
import 'package:seleraku/app/modules/save_resep/views/save_resep_view.dart';

class MainController extends GetxController {
  RxInt currentIndext = 0.obs;
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final LogoutUsecase logout;

  MainController(this.auth, this.firestore, this.logout);

  final currentPage = [
    HomeView(),
    SaveResepView(),
    DetailUserView(),
    ProfileView(),
  ];

  Future<void> callLogout() {
    return logout.call();
  }
}
