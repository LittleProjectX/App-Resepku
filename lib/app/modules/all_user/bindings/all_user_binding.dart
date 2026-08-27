import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/getuser_bylistid_usecase.dart';

import '../controllers/all_user_controller.dart';

class AllUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUserController>(
      () => AllUserController(Get.find(), Get.find()),
    );
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut(() => GetAllResepUsecase(Get.find()));
    Get.lazyPut(() => GetuserBylistidUsecase(Get.find()));
  }
}
