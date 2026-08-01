import 'package:seleraku/app/data/entities/data_resep_entity.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetResepByidUsecase {
  final DataRepository repository;
  GetResepByidUsecase(this.repository);

  Future<DataResepEntity> call(String rId) {
    return repository.getResepbyId(rId);
  }
}
