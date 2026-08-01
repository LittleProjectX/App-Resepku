import 'package:seleraku/app/domain/repositories/data_repository.dart';

class LikeResepUsecase {
  final DataRepository repository;
  LikeResepUsecase(this.repository);

  Future<void> call(String uId, String rId, int likes) async {
    return repository.likeResep(uId, rId, likes);
  }
}
