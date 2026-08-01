import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class GetAuthorFavUsecase {
  final DataRepository repository;
  GetAuthorFavUsecase(this.repository);

  Stream<QuerySnapshot<Map<String, dynamic>>> call(String uId, String afId) {
    return repository.getAuthorFav(uId, afId);
  }
}
