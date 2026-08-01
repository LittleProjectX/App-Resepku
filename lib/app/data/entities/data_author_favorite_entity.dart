import 'package:cloud_firestore/cloud_firestore.dart';

class DataAuthorFavoriteEntity {
  final String afId;
  final String aId;
  final String uId;
  final String name;
  final Timestamp createdAt;
  DataAuthorFavoriteEntity({
    required this.afId,
    required this.aId,
    required this.uId,
    required this.name,
    required this.createdAt,
  });
}
