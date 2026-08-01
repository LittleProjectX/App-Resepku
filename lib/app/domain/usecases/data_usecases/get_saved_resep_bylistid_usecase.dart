import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetSavedResepBylistidUsecase {
  final DataRepository repository;
  GetSavedResepBylistidUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call(List<String> listId) async {
    return await repository.getSavedResepByListId(listId);
  }
}
