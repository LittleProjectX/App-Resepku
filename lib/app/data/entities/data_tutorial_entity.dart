class DataTutorialEntity {
  final String tutorial;
  final DateTime createdAt;
  DataTutorialEntity({required this.tutorial, required this.createdAt});

  Map<String, dynamic> toJson() {
    return {'tutorial': tutorial, 'createdAt': createdAt};
  }
}
