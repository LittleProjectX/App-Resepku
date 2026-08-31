import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_resep_byid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/update_resep_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/upload_image_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';

import '../controllers/update_resep_controller.dart';

class UpdateResepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateResepController>(
      () => UpdateResepController(
        Get.find<UploadImageUsecase>(),
        Get.find<UpdateResepUsecase>(),
        Get.find<GetResepByidUsecase>(),
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
    Get.lazyPut(() => UploadImageUsecase(Get.find()));
    Get.lazyPut(() => UpdateResepUsecase(Get.find()));
    Get.lazyPut(() => GetResepByidUsecase(Get.find()));
  }
}
