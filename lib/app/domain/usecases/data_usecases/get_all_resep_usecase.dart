import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAllResepUsecase {
  final DataRepository repository;
  GetAllResepUsecase(this.repository);

  Future<List<Map<String, dynamic>>> call() {
    return repository.getAllResep();
  }
}
