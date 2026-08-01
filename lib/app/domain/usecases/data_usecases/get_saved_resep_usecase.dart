import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetSavedResepUsecase {
  final DataRepository repository;
  GetSavedResepUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call(String uId) async {
    return await repository.getSavedResep(uId);
  }
}
