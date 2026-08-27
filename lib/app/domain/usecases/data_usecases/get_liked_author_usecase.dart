import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetLikedAuthorUsecase {
  final DataRepository repository;
  GetLikedAuthorUsecase(this.repository);

  Future<List<Map<String, dynamic>>> call(String afId) async {
    return await repository.getLikedAuthor(afId);
  }
}
