import 'package:flutter/material.dart';
import 'package:todo/auth/models/user.dart';
import 'package:todo/auth/models/status.dart';
import 'package:todo/auth/repo/user_interface.dart';
import '../repo/auth_interface.dart';


/*
The UI will depends on the Status to decide which screen/action to be done.

- Uninitialized - Checking user is logged or not, show the Splash Screen
- Authenticated - User is authenticated successfully, show Home Page
- Authenticating - Sign In button has just been pressed, show circular indicator or progress bar
- Unauthenticated - User is not authenticated, show login page
- Registering - User just pressed registering, show circular indicator or progress bar

Remove or add more status for UI or widgets to listen to.
 */


class AuthViewModel extends ChangeNotifier {
  /*
  All this provider needs from its _authRepository dependency is a getter
  that yields an authenticated user object of type User
  */

  /*
  This view model is also responsible for pushing user details to UserRepository
  to initiate persistence of user details to db or shared preferences

  */

  // attributes
  final IAuth _authRepository;
  final IUserRepository _userRepository;
  Status _status = Status.Uninitialised;
  late User? _currentUser;


  // constructor
  AuthViewModel(this._authRepository, this._userRepository) {
    getActiveUser();
  }

  // getters
  Status get status => _status;
  User? get currentUser => _currentUser; // event & todos form widget may watch this attribute to associate each with a user

  void getActiveUser() async {
    User? activeUser = await _userRepository.getActive();
    if (activeUser != null) {
      _status = Status.Authenticated;
      _currentUser = activeUser;
    } else {
      getUserAuthStatus();
    }
    notifyListeners();
  }

  void getUserAuthStatus() {
    final authUser = _authRepository.authenticatedUser;
    if (authUser == null) {
      _status = Status.Unauthenticated;
    } else if (authUser.uid == 'null') {
      _status = Status.Unauthenticated;
    } else {
      print('User is Authenticated (uid: ${authUser.uid})');
      _status = Status.Authenticated;
    }
  }

  // **
  // NOTE:
  // If user email verification or some other process is required after signUp
  // 1. Status.Authenticated could be replaced with Status.Registered
  //    to initiate movement of the user through the relevant flow (e.g. to external route)
  // 2. _currentUser would get set within login method alone
  // **

  void signUpWithEmailAndPassword(String userEmail, String userPassword, String name, String phone) async {
    _status = Status.Registering;
    notifyListeners();
    User userResponse = await _authRepository.signUpWithEmailAndPassword(userEmail, userPassword);

    if (userResponse.uid != 'null') {
      // persist user data
      User user = User(uid: userResponse.uid, email: userEmail, displayName: name, phoneNumber: phone);
      await _userRepository.insert(user);
      // change state
      _currentUser = user;
      _status = Status.Authenticated;
      notifyListeners();
    } else {
      _status = Status.Unauthenticated;
      notifyListeners();
    }
  }


  Future<void> signInWithEmailAndPassword(String userEmail, String userPassword) async {
    _status = Status.Authenticating;
    notifyListeners();
    bool signedIn = await _authRepository.signInWithEmailAndPassword(userEmail, userPassword);
    await _setCurrentLoggedInUser(userEmail);
    if (signedIn && _currentUser != null) {

    // if (signedIn) {
        _status = Status.Authenticated;
        notifyListeners();
      } else {
        _status = Status.Unauthenticated;
        notifyListeners();
      }
    }

  // sign out user
  Future signOut() async {
    _authRepository.signOut();
    _status = Status.Unauthenticated;
    _deactivateLoggedOutUser();
    notifyListeners();
  }

  Future<void> _setCurrentLoggedInUser(String userEmail) async {
    try {
      _currentUser = await _userRepository.getOne(userEmail);
      await _userRepository.setActive(_currentUser!);
    } catch (e) {
      print(e);
      // show snack with "login failed"
    }
  }

  void _deactivateLoggedOutUser() async {
    await _userRepository.deactivate(_currentUser!);
    _currentUser = null;
  }
}


