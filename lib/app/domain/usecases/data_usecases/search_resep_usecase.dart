import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SearchResepUsecase {
  final DataRepository dataRepository;
  SearchResepUsecase(this.dataRepository);

  Stream<List<QueryDocumentSnapshot>> call(String title) {
    return dataRepository.searchResep(title);
  }
}
