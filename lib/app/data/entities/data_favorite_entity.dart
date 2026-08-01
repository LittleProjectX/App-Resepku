import 'package:cloud_firestore/cloud_firestore.dart';

class DataFavoriteEntity {
  final String fId;
  final String rId;
  final String uId;
  final Timestamp createdAt;

  DataFavoriteEntity({
    required this.fId,
    required this.rId,
    required this.uId,
    required this.createdAt,
  });
}
