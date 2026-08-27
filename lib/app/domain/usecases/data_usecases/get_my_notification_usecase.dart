import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetMyNotificationUsecase {
  final DataRepository repository;
  GetMyNotificationUsecase(this.repository);

  Future<List<Map<String, dynamic>>> call(String uId) {
    return repository.getMyNotification(uId);
  }
}
