import 'package:seleraku/app/domain/repositories/data_repository.dart';

class LikeAuthorUsecase {
  final DataRepository repository;
  LikeAuthorUsecase(this.repository);

  Future<void> call(String uId, String afId, int likes) async {
    return await repository.likeAuthor(uId, afId, likes);
  }
}
