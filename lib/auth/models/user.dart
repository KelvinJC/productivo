

class User {
  String uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;

  User({
    required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl
  });
}
