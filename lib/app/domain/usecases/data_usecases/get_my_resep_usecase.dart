import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetMyResepUsecase {
  final DataRepository repository;
  GetMyResepUsecase(this.repository);

  Stream<List<QueryDocumentSnapshot>> call(String uId) {
    return repository.getMyResep(uId);
  }
}
