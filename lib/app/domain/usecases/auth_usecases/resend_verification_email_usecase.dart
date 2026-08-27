import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class ResendVerificationEmailUsecase {
  final AuthRepository repository;
  ResendVerificationEmailUsecase(this.repository);

  Future<void> call() {
    return repository.resendVerificationEmail();
  }
}
