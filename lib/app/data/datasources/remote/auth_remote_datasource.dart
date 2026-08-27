import 'package:firebase_auth/firebase_auth.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';

abstract class AuthRemoteDatasource {
  Future<UserCredential> login(String email, String password);
  Future<DataUserEntity?> register(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> logout();
  Stream<User?> getStream();
  String getCurrentUid();
  Future<UserCredential?> loginWithGoogle();
  Future<void> updatePassword(String newPassword);
  Future<void> resendVerificationEmail();
}
