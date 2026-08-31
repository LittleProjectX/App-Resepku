import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/auth_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/resend_verification_email_usecase.dart';

import '../controllers/confirm_email_regis_controller.dart';

class ConfirmEmailRegisBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmEmailRegisController>(
      () => ConfirmEmailRegisController(
        Get.find<ResendVerificationEmailUsecase>(),
      ),
    );
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(Get.find(), Get.find()),
    );
    Get.lazyPut(() => ResendVerificationEmailUsecase(Get.find()));
  }
}
