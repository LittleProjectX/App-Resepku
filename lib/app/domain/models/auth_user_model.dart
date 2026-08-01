import 'package:seleraku/app/data/entities/auth_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

class AuthUserModel extends AuthUserEntity {
  AuthUserModel({
    required super.uId,
    required super.email,
    required super.isVerified,
  });

  factory AuthUserModel.fromFirebase(fa.User user) {
    return AuthUserModel(
      uId: user.uid,
      email: user.email ?? '',
      isVerified: user.emailVerified,
    );
  }
}
