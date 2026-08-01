import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_ingredient_entity.dart';

class DataIngredientModel extends DataIngredientEntity {
  DataIngredientModel({
    required super.ingredient,
    required super.amount,
    required super.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {'ingredient': ingredient, 'amount': amount, 'createdAt': createdAt};
  }

  factory DataIngredientModel.fromJson(Map<String, dynamic> json) {
    return DataIngredientModel(
      ingredient: json['ingredient'] ?? '',
      amount: json['amount'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}
