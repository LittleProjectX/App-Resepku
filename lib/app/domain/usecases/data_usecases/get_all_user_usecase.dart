import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAllUserUsecase {
  final DataRepository repository;
  GetAllUserUsecase(this.repository);

  Future<List<DataUserModel>> call() {
    return repository.getAllUser();
  }
}
