import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_author_favorite_entity.dart';

class DataAuthorFavoriteModel extends DataAuthorFavoriteEntity {
  DataAuthorFavoriteModel({
    required super.afId,
    required super.aId,
    required super.uId,
    required super.name,
    required super.createdAt,
  });

  factory DataAuthorFavoriteModel.fromFirebase(Map<String, dynamic> json) {
    return DataAuthorFavoriteModel(
      afId: json['afId'] ?? '',
      aId: json['aId'] ?? '',
      uId: json['uId'] ?? '',
      name: json['name'] ?? '',
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
