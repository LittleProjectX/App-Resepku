import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_all_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/getuser_bylistid_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';

import '../controllers/all_user_controller.dart';

class AllUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUserController>(
      () => AllUserController(
        Get.find<GetAllResepUsecase>(),
        Get.find<GetuserBylistidUsecase>(),
      ),
    );
    Get.lazyPut<DataRepository>(
      () => DataRepositoryImpl(
        Get.find<DataRemoteDatasource>(),
        Get.find<IsConnectedUsecase>(),
        Get.find<UserLocalDatasource>(),
        Get.find<ResepLocalDatasource>(),
      ),
    );
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut(() => GetAllResepUsecase(Get.find()));
    Get.lazyPut(() => GetuserBylistidUsecase(Get.find()));
  }
}
