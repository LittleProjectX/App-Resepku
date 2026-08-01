import 'package:seleraku/app/data/entities/auth_user_entity.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  Future<AuthUserEntity?> call(String email, String password) {
    return repository.login(email, password);
  }
}
