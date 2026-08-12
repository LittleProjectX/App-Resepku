import 'package:firebase_auth/firebase_auth.dart';
import 'package:seleraku/app/data/datasources/auth_remote_datasource.dart';
import 'package:seleraku/app/data/entities/auth_user_entity.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<AuthUserEntity?> login(String email, String password) async {
    final credential = await remote.login(email, password);

    final user = credential.user;
    if (user == null) return null;

    return AuthUserEntity(
      uId: user.uid,
      email: user.email.toString(),
      isVerified: user.emailVerified,
    );
  }

  @override
  Future<DataUserEntity?> register(String email, String password) async {
    return await remote.register(email, password);
  }

  @override
  Future<void> resetPassword(String email) async {
    return await remote.resetPassword(email);
  }

  @override
  Future<void> logout() async {
    return await remote.logout();
  }

  @override
  Stream<User?> getStream() {
    return remote.getStream();
  }

  @override
  String getCurrentUid() {
    return remote.getCurrentUid();
  }

  @override
  Future<AuthUserEntity?> loginWithGoogle() async {
    final credential = await remote.loginWithGoogle();

    final user = credential?.user;
    if (user == null) return null;

    return AuthUserEntity(
      uId: user.uid,
      email: user.email.toString(),
      isVerified: user.emailVerified,
    );
  }
}
