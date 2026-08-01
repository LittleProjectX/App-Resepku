import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SetuserProfileUsecase {
  final DataRepository repository;
  SetuserProfileUsecase(this.repository);

  Future<void> call(String uId, String name, String email, String phone) {
    return repository.setUserProfile(uId, name, email, phone);
  }
}
