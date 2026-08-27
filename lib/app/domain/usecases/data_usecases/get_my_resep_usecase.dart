import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetMyResepUsecase {
  final DataRepository repository;
  GetMyResepUsecase(this.repository);

  Stream<List<Map<String, dynamic>>> call(String uId) {
    return repository.getMyResep(uId);
  }
}
