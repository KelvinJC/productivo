

class User {
  final String  uid;
  String? email;
  String? displayName;
  String? phoneNumber;
  String? photoUrl;
  bool?   isActive;

  User({
    required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoUrl,
    this.isActive
  });

  Map<String, dynamic> toMap() {
    return {
    'uid':  uid,
    'email': email,
    'display_name': displayName,
    'phone_number': phoneNumber,
    'photo_url': photoUrl,
    'is_active':   isActive,
    };
  }

  User.fromMap(Map<String, dynamic> data) :
    uid         = data['uid'],
    email       = data['email'],
    displayName = data['display_name'],
    phoneNumber = data['phone_number'],
    photoUrl    = data['photo_url'],
    isActive    = data['is_active'];

  @override
  String toString() {
    return 'User{'
        'uid: $uid, '
        'email: $email, '
        'displayName: $displayName, '
        'phoneNumber: $phoneNumber, '
        'photoUrl: $photoUrl,'
        'isActive: $isActive'
        '}';
  }

}

