import 'package:seleraku/app/domain/repositories/data_repository.dart';

class DislikeAuthorUsecase {
  final DataRepository repository;
  DislikeAuthorUsecase(this.repository);

  Future<void> call(String afId, String aId, int likes) async {
    return await repository.unLikeAthor(afId, aId, likes);
  }
}
