import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetuserBylistidUsecase {
  final DataRepository repository;
  GetuserBylistidUsecase(this.repository);

  Future<List<Map<String, dynamic>>> call(List<String> listId) {
    return repository.getUserByListId(listId);
  }
}
