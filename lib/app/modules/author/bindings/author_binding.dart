import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/dislike_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_author_fav_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/like_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';

import '../controllers/author_controller.dart';

class AuthorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorController>(
      () => AuthorController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut(() => GetUserOnceUsecase(Get.find()));
    Get.lazyPut(() => SendNotificationUsecase(Get.find()));
    Get.lazyPut(() => GetMyResepUsecase(Get.find()));
    Get.lazyPut(() => LikeAuthorUsecase(Get.find()));
    Get.lazyPut(() => DislikeAuthorUsecase(Get.find()));
    Get.lazyPut(() => GetAuthorFavUsecase(Get.find()));
  }
}
