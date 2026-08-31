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

  factory DataResepModel.fromFirebase(Map<String, dynamic> data) {
    return DataResepModel(
      rId: data['rId'] ?? '',
      uId: data['uId'] ?? '',
      author: data['author'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      portion: data['portion'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      mainIngredient: (data['mainIngredient'] as List)
          .map(
            (e) => DataIngredientModel.fromFirebase(e as Map<String, dynamic>),
          )
          .toList(),
      additive: (data['additive'] as List)
          .map(
            (e) => DataIngredientModel.fromFirebase(e as Map<String, dynamic>),
          )
          .toList(),
      tutorial: (data['tutorial'] as List)
          .map((e) => DataTutorialModel.fromFirebase(e as Map<String, dynamic>))
          .toList(),
      likes: data['likes'] ?? 0,
      saves: data['saves'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory DataResepModel.fromJson(Map<String, dynamic> json) {
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
          .map(
            (e) => DataIngredientModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList(),
      additive: (json['additive'] as List)
          .map(
            (e) => DataIngredientModel.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList(),
      tutorial: (json['tutorial'] as List)
          .map((e) => DataTutorialModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
      likes: json['likes'] ?? 0,
      saves: json['saves'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rId': rId,
      'uId': uId,
      'author': author,
      'title': title,
      'description': description,
      'portion': portion,
      'category': category,
      'imageUrl': imageUrl,
      'mainIngredient': mainIngredient
          .map((ingredient) => ingredient.toJson())
          .toList(),
      'additive': additive.map((ingredient) => ingredient.toJson()).toList(),
      'tutorial': tutorial.map((tutorial) => tutorial.toJson()).toList(),
      'likes': likes,
      'saves': saves,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
