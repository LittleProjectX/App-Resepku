import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class UpdatePasswordUsecase {
  final AuthRepository repository;
  UpdatePasswordUsecase(this.repository);

  Future<void> call(String newPassword) {
    return repository.updatePassword(newPassword);
  }
}
