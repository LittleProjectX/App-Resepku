import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetLikedAuthorUsecase {
  final DataRepository repository;
  GetLikedAuthorUsecase(this.repository);

  Future<List<QueryDocumentSnapshot>> call(String afId) async {
    return await repository.getLikedAuthor(afId);
  }
}
