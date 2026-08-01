import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';

class DataResepModel extends DataResepEntity {
  DataResepModel({
    required super.rId,
    required super.uId,
    required super.author,
    required super.title,
    required super.description,
    required super.portion,
    required super.category,
    required super.imageUrl,
    required super.mainIngredient,
    required super.additive,
    required super.tutorial,
    required super.likes,
    required super.saves,
    required super.createdAt,
  });

  factory DataResepModel.fromFirebase(Map<String, dynamic> json) {
    return DataResepModel(
      rId: json['rId'] ?? '',
      uId: json['uId'] ?? '',
      author: json['author'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      portion: json['portion'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      mainIngredient: (json['mainIngredient'] as List)
          .map((e) => DataIngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      additive: (json['additive'] as List)
          .map((e) => DataIngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      tutorial: (json['tutorial'] as List)
          .map((e) => DataTutorialModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] ?? 0,
      saves: json['saves'] ?? 0,
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rId': rId,
      'uId': uId,
      'title': title,
      'description': description,
      'portion': portion,
      'category': category,
      'imageUrl': imageUrl,
      'mainIngredient': mainIngredient,
      'additive': additive,
      'tutorial': tutorial,
      'likes': likes,
      'saves': saves,
      'createdAt': createdAt,
    };
  }
}
