class DataUserEntity {
  final String uId;
  final String? name;
  final String? phone;
  final String? imageUrl;
  final String email;
  final bool isProfileComplete;
  final int likes;
  final DateTime createdAt;
  DataUserEntity({
    required this.uId,
    this.name,
    this.phone,
    this.imageUrl,
    required this.email,
    required this.isProfileComplete,
    required this.likes,
    required this.createdAt,
  });
}
