import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAllResepUsecase {
  final DataRepository repository;
  GetAllResepUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call() {
    return repository.getAllResep();
  }
}
