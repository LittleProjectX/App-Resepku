import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/resep_local_datasource_impl.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource.dart';
import 'package:seleraku/app/data/datasources/local/user_local_datasource_impl.dart';
import 'package:seleraku/app/data/datasources/remote/auth_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/auth_remote_datasource_impl.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/data_remote_datasource_impl.dart';
import 'package:seleraku/app/data/datasources/remote/network_remote_datasource.dart';
import 'package:seleraku/app/data/datasources/remote/network_remote_datasource_impl.dart';
import 'package:seleraku/app/data/repositories/auth_repository_impl.dart';
import 'package:seleraku/app/data/repositories/data_repository_impl.dart';
import 'package:seleraku/app/data/repositories/network_repository_impl.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';
import 'package:seleraku/app/domain/repositories/network_repository.dart';
import 'package:seleraku/app/domain/usecases/auth_usecases/get_stream_usecase.dart';
import 'package:seleraku/app/domain/usecases/data_usecases/get_user_usecase.dart';
import 'package:seleraku/app/domain/usecases/network_usecases/is_connected_usecase.dart';
import 'package:seleraku/app/modules/auth_gate/controllers/auth_gate_controller.dart';

class AuthGateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(Get.find(), Get.find()),
    );
    Get.lazyPut<DataRemoteDatasource>(
      () => DataRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<NetworkRepository>(() => NetworkRepositoryImpl(Get.find()));
    Get.lazyPut<NetworkRemoteDatasource>(
      () => NetworkRemoteDatasourceImpl(Get.find()),
    );
    Get.lazyPut<UserLocalDatasource>(
      () => UserLocalDatasourceImpl(Hive.box('user')),
    );
    Get.lazyPut<ResepLocalDatasource>(
      () => ResepLocalDatasourceImpl(Hive.box('reseps')),
    );
    Get.lazyPut(() => InternetConnection());
    Get.lazyPut<DataRepository>(
      () => DataRepositoryImpl(
        Get.find<DataRemoteDatasource>(),
        Get.find<IsConnectedUsecase>(),
        Get.find<UserLocalDatasource>(),
        Get.find<ResepLocalDatasource>(),
      ),
    );
    Get.lazyPut(() => GetuserUsecase(Get.find()));
    Get.lazyPut(() => GetStreamUsecase(Get.find()));
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find()));
    Get.lazyPut(() => IsConnectedUsecase(Get.find()));
    Get.put<AuthGateController>(
      AuthGateController(
        Get.find<GetStreamUsecase>(),
        Get.find<GetuserUsecase>(),
        Get.find<IsConnectedUsecase>(),
      ),
    );
  }
}
