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
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
  factory DataFavoriteModel.fromJson(Map<String, dynamic> json) {
    return DataFavoriteModel(
      fId: json['fId'] ?? '',
      uId: json['uId'] ?? '',
      rId: json['rId'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'fId': fId,
      'uId': uId,
      'rId': rId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
