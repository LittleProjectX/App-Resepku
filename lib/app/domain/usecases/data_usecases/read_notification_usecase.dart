import 'package:seleraku/app/domain/repositories/data_repository.dart';

class ReadNotificationUsecase {
  final DataRepository repository;
  ReadNotificationUsecase(this.repository);

  Future<void> call(String uId, String notifId, bool isRead) {
    return repository.readNotification(uId, notifId, isRead);
  }
}
