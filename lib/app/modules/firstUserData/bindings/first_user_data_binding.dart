import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_once_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/setUser_profile_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';

import '../controllers/first_user_data_controller.dart';

class FirstUserDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirstUserDataController>(
      () => FirstUserDataController(
        Get.find<GetUserOnceUsecase>(),
        Get.find<GetCurrentUidUsecase>(),
        Get.find<SetuserProfileUsecase>(),
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
    Get.lazyPut(() => GetUserOnceUsecase(Get.find()));
    Get.lazyPut(() => SetuserProfileUsecase(Get.find()));
    Get.lazyPut(() => GetCurrentUidUsecase(Get.find()));
  }
}
