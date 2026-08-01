import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;
  RegisterUsecase(this.repository);

  Future<void> call(String email, String password) {
    return repository.register(email, password);
  }
}
