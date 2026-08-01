import 'package:seleraku/app/domain/repositories/data_repository.dart';

class UnsaveResepUsecase {
  final DataRepository repository;
  UnsaveResepUsecase(this.repository);

  Future<void> call(String fId, String rId, int saves) {
    return repository.unSaveResep(fId, rId, saves);
  }
}
