import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/domain/repositories/data_repository.dart';

class SendReportUsecase {
  final DataRepository repository;
  SendReportUsecase(this.repository);

  Future<void> call(String uId, String report, Timestamp createdAt) {
    return repository.sendReport(uId, report, createdAt);
  }
}
