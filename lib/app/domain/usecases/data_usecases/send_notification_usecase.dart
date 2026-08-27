import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SendNotificationUsecase {
  final DataRepository repository;
  SendNotificationUsecase(this.repository);

  Future<void> call(
    String senderId,
    List<String> receiverId,
    String imageUrl,
    String title,
    String msg,
    bool isRead,
    DateTime createdAt,
  ) async {
    return await repository.sendNotification(
      senderId,
      receiverId,
      imageUrl,
      title,
      msg,
      isRead,
      createdAt,
    );
  }
}
