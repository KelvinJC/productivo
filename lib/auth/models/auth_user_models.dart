

class AuthUserModel {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;

  AuthUserModel({
    required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl
  });
}
