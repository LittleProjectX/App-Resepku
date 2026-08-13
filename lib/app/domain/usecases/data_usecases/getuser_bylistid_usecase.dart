import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetuserBylistidUsecase {
  final DataRepository repository;
  GetuserBylistidUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call(List<String> listId) {
    return repository.getUserByListId(listId);
  }
}
