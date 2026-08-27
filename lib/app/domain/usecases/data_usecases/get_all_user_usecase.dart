import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAllUserUsecase {
  final DataRepository repository;
  GetAllUserUsecase(this.repository);

  Future<List<Map<String, dynamic>>> call() {
    return repository.getAllUser();
  }
}
