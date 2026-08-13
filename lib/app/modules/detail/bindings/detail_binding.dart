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
import 'package:seleraku/app/domain/usecases/data_usecases/dislike_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_like_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_resep_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_save_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/like_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/save_to_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/unsave_resep_usecase.dart';

import '../controllers/detail_controller.dart';

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(
      () => DetailController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => GetResepByidUsecase(Get.find()));
    Get.lazyPut(() => SendNotificationUsecase(Get.find()));
    Get.lazyPut(() => GetUserOnceUsecase(Get.find()));
    Get.lazyPut(() => GetSaveByidUsecase(Get.find()));
    Get.lazyPut(() => GetLikeByidUsecase(Get.find()));
    Get.lazyPut(() => SaveToMyResepUsecase(Get.find()));
    Get.lazyPut(() => UnsaveResepUsecase(Get.find()));
    Get.lazyPut(() => LikeResepUsecase(Get.find()));
    Get.lazyPut(() => DislikeResepUsecase(Get.find()));
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(Get.find(), Get.find()),
    );
  }
}
