import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/auth/models/status.dart';
import 'package:todo/auth/models/auth_user_models.dart';


/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, show the Splash Screen
- Authenticated - User is authenticated successfully, show Home Page
- Authenticating - Sign In button has just been pressed, show circular indicator or progress bar
- Unauthenticated - User is not authenticated, show login page
- Registering - User just pressed registering, show circular indicator or progress bar

Remove or add more status for UI or widgets to listen to.
 */


class FirebaseAuthViewModel extends ChangeNotifier {
  // attributes
  late FirebaseAuth _auth;
  Status _status = Status.Uninitialised;

  // constructor
  FirebaseAuthViewModel() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen(onAuthStateChanged);
  }

  // getters
  Status get status => _status;
  Stream<AuthUserModel> get user => _auth.authStateChanges().map(_userFromFirebase);


  // create user object based on given user
  AuthUserModel _userFromFirebase(User? user) {
    if (user == null) {
      return AuthUserModel(
          uid: 'null',
          displayName: 'Null',
          email: 'null'
      );
    } return AuthUserModel(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL
    );
  }

  // detect live auth changes such as user sign in or sign out
  Future<void> onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  // sign up new user
  Future<AuthUserModel> signUpWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      final UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword
      );
      return _userFromFirebase(result.user);
    } on FirebaseAuthException catch(e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return AuthUserModel(displayName: 'Null', uid: 'null');
    }
  }

  // sign in user
  Future<bool> signInWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword
      );
      return true;
    } catch(e) {
      print("Error on the sign in = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  // password reset
  Future<void> sendPasswordResetEmail(String userEmail) async {
      await _auth.sendPasswordResetEmail(email: userEmail);
  }

  // sign out user
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  void printCreds(String pwd, String confPwd ) {
    if (pwd == confPwd) {
      print('$pwd, $confPwd');
    }

  }

  }



