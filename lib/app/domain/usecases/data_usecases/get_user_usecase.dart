import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetuserUsecase {
  final DataRepository repository;
  GetuserUsecase(this.repository);

  Stream<DocumentSnapshot<Map<String, dynamic>>> call(String uId) {
    return repository.getUser(uId);
  }
}
