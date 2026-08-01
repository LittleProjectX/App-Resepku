import 'package:seleraku/app/domain/repositories/auth_repository.dart';

class GetCurrentUidUsecase {
  final AuthRepository repository;
  GetCurrentUidUsecase(this.repository);

  String call() {
    return repository.getCurrentUid();
  }
}
