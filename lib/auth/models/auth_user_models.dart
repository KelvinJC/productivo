

class AuthUser {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;

  AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl
  });
}
