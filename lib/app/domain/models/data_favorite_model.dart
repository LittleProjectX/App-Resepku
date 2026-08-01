import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_favorite_entity.dart';

class DataFavoriteModel extends DataFavoriteEntity {
  DataFavoriteModel({
    required super.fId,
    required super.rId,
    required super.uId,
    required super.createdAt,
  });

  factory DataFavoriteModel.fromFirebase(Map<String, dynamic> json) {
    return DataFavoriteModel(
      fId: json['fId'] ?? '',
      uId: json['uId'] ?? '',
      rId: json['rId'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}
