import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_current_uid_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/send_report_usecase.dart';

import '../controllers/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(
      () => ReportController(Get.find(), Get.find()),
    );
    Get.lazyPut<DataRepository>(() => DataRepositoryImpl(Get.find()));
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut(() => GetCurrentUidUsecase(Get.find()));
    Get.lazyPut(() => SendReportUsecase(Get.find()));
  }
}
