import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_notification_entity.dart';

class DataNotificationModel extends DataNotificationEntity {
  DataNotificationModel({
    required super.docId,
    required super.senderId,
    required super.receiverId,
    required super.title,
    required super.msg,
    required super.imageUrl,
    required super.isRead,
    required super.createdAt,
  });

  factory DataNotificationModel.fromFirebase(Map<String, dynamic> json) {
    return DataNotificationModel(
      docId: json['docId'] ?? '',
      senderId: json['senderId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      title: json['title'] ?? '',
      msg: json['msg'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      isRead: json['isRead'] ?? false,
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}
