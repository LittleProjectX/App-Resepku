import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';

class DataResepEntity {
  final String rId;
  final String uId;
  final String author;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final String portion;
  final List<DataIngredientModel> mainIngredient;
  final List<DataIngredientModel> additive;
  final List<DataTutorialModel> tutorial;
  final int likes;
  final int saves;
  final DateTime createdAt;
  DataResepEntity({
    required this.rId,
    required this.uId,
    required this.author,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.portion,
    required this.mainIngredient,
    required this.additive,
    required this.tutorial,
    required this.likes,
    required this.saves,
    required this.createdAt,
  });
}
