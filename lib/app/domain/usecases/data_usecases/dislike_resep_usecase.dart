import 'package:seleraku/app/domain/repositories/data_repository.dart';

class DislikeResepUsecase {
  final DataRepository repository;
  DislikeResepUsecase(this.repository);

  Future<void> call(String fId, int likes, String rId) async {
    return repository.disLikeResep(fId, likes, rId);
  }
}
