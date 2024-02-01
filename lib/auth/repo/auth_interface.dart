import 'package:todo/auth/models/auth_user_models.dart';

abstract class IAuth {
  AuthUser? get authenticatedUser;
  Future<AuthUser> signUpWithEmailAndPassword(String userEmail, String userPassword);
  Future<bool> signInWithEmailAndPassword(String userEmail, String userPassword);
  Future<void> sendPasswordResetEmail(String userEmail);
  Future<dynamic> signOut();
}


// NOTES
// on using Object Oriented Interface and Factory Design Pattern
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



// may have to make the returned user of signupwithemailandpassword more loose
// to accomodate what google auth sends back
// alternatives are:
//   - <dynamic>,
//   - <User> a user class with just username and password attributes
//   - modifying the implementation within the method to return similar object
//   - etc.