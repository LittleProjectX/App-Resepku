import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/dislike_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_author_fav_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_author_usercase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_my_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/like_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';

import '../controllers/author_controller.dart';

class AuthorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthorController>(
      () => AuthorController(
        Get.find<GetCurrentUidUsecase>(),
        Get.find<GetAuthorUsercase>(),
        Get.find<GetMyResepUsecase>(),
        Get.find<GetAuthorFavUsecase>(),
        Get.find<LikeAuthorUsecase>(),
        Get.find<DislikeAuthorUsecase>(),
        Get.find<SendNotificationUsecase>(),
      ),
    );
    Get.lazyPut(() => GetCurrentUidUsecase(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<DataRepository>(
      () => DataRepositoryImpl(
        Get.find<DataRemoteDatasource>(),
        Get.find<IsConnectedUsecase>(),
        Get.find<UserLocalDatasource>(),
        Get.find<ResepLocalDatasource>(),
      ),
    );
    Get.lazyPut(() => GetAuthorUsercase(Get.find()));
    Get.lazyPut(() => SendNotificationUsecase(Get.find()));
    Get.lazyPut(() => GetMyResepUsecase(Get.find()));
    Get.lazyPut(() => LikeAuthorUsecase(Get.find()));
    Get.lazyPut(() => DislikeAuthorUsecase(Get.find()));
    Get.lazyPut(() => GetAuthorFavUsecase(Get.find()));
  }
}
