import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/setUser_profile_usecase.dart';

import '../controllers/first_user_data_controller.dart';

class FirstUserDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut(() => GetUserOnceUsecase(Get.find()));
    Get.lazyPut(() => SetuserProfileUsecase(Get.find()));
    Get.lazyPut<FirstUserDataController>(
      () => FirstUserDataController(Get.find(), Get.find(), Get.find()),
    );
  }
}
