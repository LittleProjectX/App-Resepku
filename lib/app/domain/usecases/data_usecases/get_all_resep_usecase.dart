import 'package:seleraku/app/domain/models/data_resep_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAllResepUsecase {
  final DataRepository repository;
  GetAllResepUsecase(this.repository);

  Future<List<DataResepModel>> call() {
    return repository.getAllResep();
  }
}
