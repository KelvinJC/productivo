import 'package:firebase_auth/firebase_auth.dart';


class FirebaseAuthService {
  static createUserWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
    } on FirebaseAuthException catch(e) {
      print(e);
    }
  }

  static signInWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword
      );
    } on FirebaseAuthException catch(e) {
      print(e.message);
      print(e.code);
    }
  }

  static passwordReset(String userEmail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
    } on FirebaseAuthException catch(e) {
      print(e);
    }
  }
}
