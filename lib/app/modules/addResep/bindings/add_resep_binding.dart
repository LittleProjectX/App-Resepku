import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_liked_author_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/save_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_notification_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/upload_image_usecase.dart';

import '../controllers/add_resep_controller.dart';

class AddResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut(() => UploadImageUsecase(Get.find()));
    Get.lazyPut(() => GetLikedAuthorUsecase(Get.find()));
    Get.lazyPut(() => SendNotificationUsecase(Get.find()));

    Get.lazyPut(() => SaveResepUsecase(Get.find()));
    Get.lazyPut<AddResepController>(
      () => AddResepController(
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
    );
  }
}
