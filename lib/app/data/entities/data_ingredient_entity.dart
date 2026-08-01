import 'package:cloud_firestore/cloud_firestore.dart';

class DataIngredientEntity {
  final String ingredient;
  final String amount;
  final Timestamp createdAt;

  DataIngredientEntity({
    required this.ingredient,
    required this.amount,
    required this.createdAt,
  });
}
