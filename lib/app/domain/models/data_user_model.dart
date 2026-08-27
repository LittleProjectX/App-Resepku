import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_user_entity.dart';

class DataUserModel extends DataUserEntity {
  DataUserModel({
    required super.uId,
    super.name,
    super.phone,
    super.imageUrl,
    required super.email,
    required super.isProfileComplete,
    required super.likes,
    required super.createdAt,
  });
  factory DataUserModel.fromFirebase(Map<String, dynamic> json) {
    return DataUserModel(
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      imageUrl: json['imageUrl'],
      email: json['email'] ?? '',
      isProfileComplete: json['isProfileComplete'] ?? false,
      likes: json['likes'] ?? 0,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'phone': phone,
      'imageUrl': imageUrl,
      'email': email,
      'isProfileComplete': isProfileComplete,
      'likes': likes,
      'createdAt': createdAt,
    };
  }
}
