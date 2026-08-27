import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SendReportUsecase {
  final DataRepository repository;
  SendReportUsecase(this.repository);

  Future<void> call(String uId, String report, DateTime createdAt) {
    return repository.sendReport(uId, report, createdAt);
  }
}
