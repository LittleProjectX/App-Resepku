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
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}



// factory DataUserModel.fromFirebase(DataUserEntity? json, String uId) {
//     if (json != null) {
//       return DataUserModel(
//         uId: json.uId,
//         email: json.email,
//         isProfileComplete: json.isProfileComplete,
//         likes: json.likes,
//         createdAt: json.createdAt,
//       );
//     } else {
//       return DataUserModel(
//         uId: '',
//         email: '',
//         isProfileComplete: false,
//         likes: 0,
//         createdAt: '',
//       );
//     }
//   }