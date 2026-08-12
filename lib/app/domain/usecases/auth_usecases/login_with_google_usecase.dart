import 'package:seleraku/app/data/entities/auth_user_entity.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class LoginWithGoogleUsecase {
  final AuthRepository repository;
  LoginWithGoogleUsecase(this.repository);

  Future<AuthUserEntity?> call() {
    return repository.loginWithGoogle();
  }
}
