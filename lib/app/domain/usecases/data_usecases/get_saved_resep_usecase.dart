import 'package:seleraku/app/domain/models/data_favorite_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetSavedResepUsecase {
  final DataRepository repository;
  GetSavedResepUsecase(this.repository);

  Future<List<DataFavoriteModel>> call(String uId) async {
    return await repository.getSavedResep(uId);
  }
}
