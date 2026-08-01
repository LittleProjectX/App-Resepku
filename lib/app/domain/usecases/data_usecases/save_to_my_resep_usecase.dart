import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SaveToMyResepUsecase {
  final DataRepository repository;
  SaveToMyResepUsecase(this.repository);

  Future<void> call(String uId, String rId, int saves) {
    return repository.saveToMyResep(uId, rId, saves);
  }
}
