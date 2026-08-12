import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:seleraku/app/data/datasources/auth_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/auth_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/auth_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/reset_password_usecase.dart';

import '../controllers/wait_reset_password_controller.dart';

class WaitResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WaitResetPasswordController>(
      () => WaitResetPasswordController(Get.find()),
    );
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => ResetPasswordUsecase(Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(Get.find(), Get.find()),
    );
  }
}
