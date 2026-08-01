import 'package:seleraku/app/domain/repositories/data_repository.dart';

class DeleteResepUsecase {
  final DataRepository repository;
  DeleteResepUsecase(this.repository);

  Future<void> call(String rId) {
    return repository.deleteResep(rId);
  }
}
