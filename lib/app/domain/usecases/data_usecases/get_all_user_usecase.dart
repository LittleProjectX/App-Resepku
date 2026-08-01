import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAllUserUsecase {
  final DataRepository repository;
  GetAllUserUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call() {
    return repository.getAllUser();
  }
}
