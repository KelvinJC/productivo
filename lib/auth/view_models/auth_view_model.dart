import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as Fb;
import 'package:todo/auth/models/status.dart';
import 'package:todo/auth/models/user.dart';


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
  late Fb.FirebaseAuth _auth;
  Status _status = Status.Uninitialised;

  // constructor
  FirebaseAuthViewModel() {
    _auth = Fb.FirebaseAuth.instance;
    _auth.authStateChanges().listen(onAuthStateChanged); // subscribe to authentication state changes
  }

  // getters
  Status get status => _status;
  Stream<User> get user => _auth.authStateChanges().map(_userFromFirebase);


  // create user object based on given user
  User _userFromFirebase(Fb.User? user) {
    if (user == null) {
      return User(
          uid: 'null',
          displayName: 'Null',
          email: 'null'
      );
    } return User(
        uid: user.uid,
        displayName: user.displayName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoURL
    );
  }

  // detect live auth changes such as user sign in or sign out
  Future<void> onAuthStateChanged(Fb.User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _userFromFirebase(firebaseUser);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  // sign up new user
  Future<User> signUpWithEmailAndPassword(String userEmail, String userPassword) async {
    try {
      _status = Status.Registering;
      notifyListeners();
      final Fb.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword
      );
      return _userFromFirebase(result.user);
    } on Fb.FirebaseAuthException catch(e) {
      print("Error on the new user registration = " + e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return User(displayName: 'Null', uid: 'null');
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


// NOTES on using Object Oriented Interface and Factory Design Pattern
// to achieve separation of concerns plus loose coupling and high cohesion
// in authentication flow of Productive mobile app:
//
// - create IAuthRepository interface
// - interface has signature methods such as signin, signup, signout methods
// - create FireBaseAuth as implementation of IAuthRepository
// - create GoogleAuth as implementation of IAuthRepository
// - any other implementation would have the signatory methods and any particular methods
// - AuthViewModel is the changeNotifier for all authentication UI
// - it contains a variable which stores the user's selected login preference'
//   and a factory method that instantiates the required implementation
//   based on the value of the variable
// - AuthViewModel also depends on IUserRepository which stores user details in local db
//   an implementation would be injected as dependency in the root widget AuthViewModel(UserRepository(db = DB.instance))
