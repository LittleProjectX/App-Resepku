import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/save_imageUrl_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/upload_image_usecase.dart';

import '../controllers/load_image_controller.dart';

class LoadImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut(() => UploadImageUsecase(Get.find()));
    Get.lazyPut(() => SaveImageurlUsecase(Get.find()));
    Get.lazyPut<LoadImageController>(
      () => LoadImageController(Get.find(), Get.find()),
    );
  }
}
