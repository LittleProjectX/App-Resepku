import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetUserOnceUsecase {
  final DataRepository repository;
  GetUserOnceUsecase(this.repository);

  Future<DataUserModel?> call(String uId) {
    return repository.getUserOnce(uId);
  }
}
