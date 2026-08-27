import 'package:seleraku/app/domain/models/data_ingredient_model.dart';
import 'package:seleraku/app/domain/models/data_tutorial_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class UpdateResepUsecase {
  final DataRepository repository;
  UpdateResepUsecase(this.repository);

  Future<void> call(
    String rId,
    String title,
    String description,
    String portion,
    String category,
    String imageUrl,
    List<DataIngredientModel> mainIngredient,
    List<DataIngredientModel> additive,
    List<DataTutorialModel> tutorial,
    DateTime createdAt,
  ) {
    return repository.updateResep(
      rId,
      title,
      description,
      portion,
      category,
      imageUrl,
      mainIngredient,
      additive,
      tutorial,
      createdAt,
    );
  }
}
