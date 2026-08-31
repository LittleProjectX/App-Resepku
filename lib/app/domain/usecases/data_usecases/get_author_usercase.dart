import 'package:seleraku/app/domain/models/data_user_model.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAuthorUsercase {
  final DataRepository repository;
  GetAuthorUsercase(this.repository);

  Future<DataUserModel?> call(String uId) {
    return repository.getAuthor(uId);
  }
}
