import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SaveImageurlUsecase {
  final DataRepository repository;
  SaveImageurlUsecase(this.repository);

  Future<void> call(String imageUrl, String uId) {
    return repository.saveImageUrl(imageUrl, uId);
  }
}
