import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetSavedResepBylistidUsecase {
  final DataRepository repository;
  GetSavedResepBylistidUsecase(this.repository);

  Future<List<Map<String, dynamic>>> call(List<String> listId) async {
    return await repository.getSavedResepByListId(listId);
  }
}
