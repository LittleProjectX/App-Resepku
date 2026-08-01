import 'package:seleraku/app/data/entities/data_user_entity.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetuserUsecase {
  final DataRepository repository;
  GetuserUsecase(this.repository);

  Future<DataUserEntity?> call(String uId) {
    return repository.getUser(uId);
  }
}
