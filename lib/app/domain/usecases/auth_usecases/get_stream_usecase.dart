import 'package:firebase_auth/firebase_auth.dart';
import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class GetStreamUsecase {
  final AuthRepository repository;
  GetStreamUsecase(this.repository);

  Stream<User?> call() {
    return repository.getStream();
  }
}
