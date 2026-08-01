import 'package:seleraku/app/data/entities/auth_user_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

abstract class AuthRepository {
  Future<AuthUserEntity?> login(String email, String password);
  Future<DataUserEntity?> register(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> logout();
  Stream<fa.User?> getStream();
  String getCurrentUid();
}
