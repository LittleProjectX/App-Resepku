import 'package:cloud_firestore/cloud_firestore.dart';

class DataReportEntity {
  final String dId;
  final String uId;
  final String report;
  final Timestamp createdAt;

  DataReportEntity({
    required this.dId,
    required this.uId,
    required this.report,
    required this.createdAt,
  });
}
