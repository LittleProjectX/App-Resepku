import 'dart:io';

import 'package:seleraku/app/domain/repositories/data_repository.dart';

class UploadImageUsecase {
  final DataRepository repository;

  UploadImageUsecase(this.repository);

  Future<String> call(File? image, String uId) {
    return repository.uploadImage(image, uId);
  }
}
