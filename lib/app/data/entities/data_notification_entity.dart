class DataNotificationEntity {
  final String docId;
  final String senderId;
  final String receiverId;
  final String title;
  final String msg;
  final String imageUrl;
  final bool isRead;
  final DateTime createdAt;

  DataNotificationEntity({
    required this.docId,
    required this.senderId,
    required this.receiverId,
    required this.title,
    required this.msg,
    required this.imageUrl,
    required this.isRead,
    required this.createdAt,
  });
}
