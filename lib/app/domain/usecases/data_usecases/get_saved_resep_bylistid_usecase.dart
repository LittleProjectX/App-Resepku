import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetSavedResepBylistidUsecase {
  final DataRepository repository;
  GetSavedResepBylistidUsecase(this.repository);

  Future<List<DataResepModel>> call(List<String> listId) async {
    return await repository.getSavedResepByListId(listId);
  }
}
