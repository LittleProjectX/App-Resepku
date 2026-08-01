class AuthUserEntity {
  final String uId;
  final String email;
  final bool isVerified;

  AuthUserEntity({
    required this.uId,
    required this.email,
    required this.isVerified,
  });
}
