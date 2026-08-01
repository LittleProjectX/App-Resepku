import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetLikeByidUsecase {
  final DataRepository repository;
  GetLikeByidUsecase(this.repository);

  Stream<QuerySnapshot<Map<String, dynamic>>> call(String uId, String rId) {
    return repository.getLikebyId(uId, rId);
  }
}
