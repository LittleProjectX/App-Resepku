import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetuserByemailUsecase {
  final DataRepository repository;
  GetuserByemailUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call(String email) {
    return repository.getUserbyEmail(email);
  }
}
