import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seleraku/app/data/entities/data_tutorial_entity.dart';

class DataTutorialModel extends DataTutorialEntity {
  DataTutorialModel({required super.tutorial, required super.createdAt});

  factory DataTutorialModel.fromJson(Map<String, dynamic> json) {
    return DataTutorialModel(
      tutorial: json['tutorial'],
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
