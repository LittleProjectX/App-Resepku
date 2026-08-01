import 'package:cloud_firestore/cloud_firestore.dart';

class DataTutorialEntity {
  final String tutorial;
  final Timestamp createdAt;
  DataTutorialEntity({required this.tutorial, required this.createdAt});

  Map<String, dynamic> toJson() {
    return {'tutorial': tutorial, 'createdAt': createdAt};
  }
}
