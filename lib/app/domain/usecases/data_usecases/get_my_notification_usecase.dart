import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetMyNotificationUsecase {
  final DataRepository repository;
  GetMyNotificationUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call(String uId) {
    return repository.getMyNotification(uId);
  }
}
