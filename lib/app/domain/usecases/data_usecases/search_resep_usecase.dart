import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SearchResepUsecase {
  final DataRepository dataRepository;
  SearchResepUsecase(this.dataRepository);

  Stream<List<Map<String, dynamic>>> call(String title) {
    return dataRepository.searchResep(title);
  }
}
