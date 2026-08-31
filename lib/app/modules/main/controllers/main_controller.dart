import 'package:get/get.dart';
import 'package:seleraku/app/modules/detailUser/views/detail_user_view.dart';
import 'package:seleraku/app/modules/home/views/home_view.dart';
import 'package:seleraku/app/modules/profile/views/profile_view.dart';
import 'package:seleraku/app/modules/save_resep/views/save_resep_view.dart';

class MainController extends GetxController {
  RxInt currentIndext = 0.obs;

  MainController();

  final currentPage = [
    HomeView(),
    SaveResepView(),
    DetailUserView(),
    ProfileView(),
  ];
}
