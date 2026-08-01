import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetSaveByidUsecase {
  final DataRepository repository;
  GetSaveByidUsecase(this.repository);

  Stream<QuerySnapshot<Map<String, dynamic>>> call(String uId, String rId) {
    return repository.getSavebyId(uId, rId);
  }
}
