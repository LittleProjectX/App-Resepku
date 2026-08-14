import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_report_entity.dart';

class DataReportModel extends DataReportEntity {
  DataReportModel({
    required super.dId,
    required super.uId,
    required super.report,
    required super.createdAt,
  });

  factory DataReportModel.fromFirebase(Map<String, dynamic> json) {
    return DataReportModel(
      dId: json['dId'] ?? '',
      uId: json['uId'] ?? '',
      report: json['report'] ?? '',
      createdAt: json['createdAt'] ?? Timestamp.now(),
    );
  }
}
