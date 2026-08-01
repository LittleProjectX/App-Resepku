import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SaveResepUsecase {
  final DataRepository repository;
  SaveResepUsecase(this.repository);

  Future<void> call(
    String uId,
    String author,
    String title,
    String description,
    String category,
    String imageUrl,
    String portion,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    int likes,
    int saves,
    Timestamp createdAt,
  ) {
    return repository.saveResep(
      uId,
      author,
      title,
      description,
      category,
      imageUrl,
      portion,
      mainIngredient,
      additive,
      tutorial,
      likes,
      saves,
      createdAt,
    );
  }
}
