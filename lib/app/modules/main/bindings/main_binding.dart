import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/auth_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/auth_remote_datasource_impl.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/auth_repository_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/logout_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/delete_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_saved_resep_bylistid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_saved_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/modules/detailUser/controllers/detail_user_controller.dart';
import 'package:seleraku/app/modules/home/controllers/home_controller.dart';
import 'package:seleraku/app/modules/save_resep/controllers/save_resep_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(Get.find(), Get.find()),
    );
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut(() => GetuserUsecase(Get.find()));
    Get.lazyPut(() => LogoutUsecase(Get.find()));
    Get.lazyPut(
      () => HomeController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
    Get.lazyPut(() => SaveResepController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(
      () =>
          DetailUserController(Get.find(), Get.find(), Get.find(), Get.find()),
    );
    Get.lazyPut(() => GetAllUserUsecase(Get.find()));
    Get.lazyPut(() => GetSavedResepBylistidUsecase(Get.find()));
    Get.lazyPut(() => GetSavedResepUsecase(Get.find()));
    Get.lazyPut(() => GetMyNotificationUsecase(Get.find()));
    Get.lazyPut(() => GetCurrentUidUsecase(Get.find()));
    Get.lazyPut(() => GetAllResepUsecase(Get.find()));
    Get.lazyPut(() => DeleteResepUsecase(Get.find()));
    Get.lazyPut(() => GetMyResepUsecase(Get.find()));
    Get.lazyPut(() => GetuserUsecase(Get.find()));
    Get.lazyPut<MainController>(
      () => MainController(Get.find(), Get.find(), Get.find()),
    );
  }
}
