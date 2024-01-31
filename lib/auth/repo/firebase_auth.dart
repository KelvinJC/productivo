import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/auth/models/auth_user_models.dart';
import 'package:todo/auth/repo/auth_interface.dart';


class FirebaseAuthRepository implements IAuth {
  // attributes
  late final FirebaseAuth _auth;
  AuthUserModel? _authenticatedUser;

  // constructor
  FirebaseAuthRepository(this._auth);

  // getters
  @override
  AuthUserModel? get authenticatedUser => _authenticatedUser;

  Stream<AuthUserModel?> get user => _auth.authStateChanges().map(_userFromFirebase);


  // sign up new user
  @override
  Future<AuthUserModel> signUpWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: userEmail, password: userPassword);
      return AuthUserModel(
          uid: result.user!.uid,
          displayName: result.user!.displayName,
          email: result.user!.email,
          phoneNumber: result.user!.phoneNumber,
          photoUrl: result.user!.photoURL
      );
    } on FirebaseAuthException catch(e) {
      print("Error on the new user registration = $e");
      return AuthUserModel(displayName: 'Null', uid: 'null');
    } on Exception catch(e) {
      return AuthUserModel(displayName: 'Null', uid: 'null');
    }
  }

  // sign in user
  @override
  Future<bool> signInWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      await _auth.signInWithEmailAndPassword(email: userEmail, password: userPassword
      );
      return true;
    } catch(e) {
      print("Error on the sign in = $e");
      return false;
    }
  }

  // password reset
  @override
  Future<void> sendPasswordResetEmail(String userEmail) async {
    await _auth.sendPasswordResetEmail(email: userEmail);
  }

  // sign out user
  @override
  Future signOut() async {
    _auth.signOut();
    return Future.delayed(Duration.zero);
  }


  // callback to set authenticated user attribute based on changes in _auth
  AuthUserModel? _userFromFirebase(User? user) {
    if (user == null) {
      _authenticatedUser = AuthUserModel(uid: 'null', displayName: 'Null', email: 'null');
      return _authenticatedUser;
    } else {
      _authenticatedUser = AuthUserModel(
        uid: user!.uid,
        displayName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL
      );
      return _authenticatedUser;
    }
  }
}

