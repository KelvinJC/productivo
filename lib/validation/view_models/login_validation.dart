import 'package:flutter/material.dart';
import 'package:todo/validation/models/validation_item.dart';
import 'package:todo/validation/models/password_validation.dart';


class LoginValidationViewModel extends ChangeNotifier {
  ValidationItem _email = ValidationItem(null, null);
  ValidatedPassword _password = ValidatedPassword(null);
  PasswordValidationError _passwordError = PasswordValidationError(null);
  bool _isPasswordVisible = false;
  bool _isLoginFormValid = false;
  bool _freezeButtonColour = false;
  bool _userLoggedOut = false;


  // getters
  ValidationItem get email => _email;
  ValidatedPassword get password => _password;
  PasswordValidationError get passwordError => _passwordError;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoginFormValid => _isLoginFormValid;
  bool get freezeButtonColour => _freezeButtonColour;
  bool get userLoggedOut => _userLoggedOut;

  // setters
  void changeEmail(String val) {
    if (val.length >= 3) {
      _email = ValidationItem(val, null);
    } else {
      _email = ValidationItem(null, "Invalid format");
    }

    _changeLoginFormValid();
  }

  void changePassword(String pwd) {
    _password = ValidatedPassword(null);

    if (pwd.length < 8) {
      _passwordError = PasswordValidationError("Password must be at least 8 characters long");
    } // check for uppercase
    else if (!RegExp(r'(?=.*[A-Z])').hasMatch(pwd)) {
      _passwordError = PasswordValidationError("Password must contain one uppercase letter");
    } // check for lowercase
    else if (!RegExp(r'(?=.*[a-z])').hasMatch(pwd)) {
      _passwordError = PasswordValidationError("Password must contain one lowercase letter");
    } // check for number
    else if (!RegExp(r'(?=.*\d)').hasMatch(pwd)) {
      _passwordError = PasswordValidationError("Password must contain one number");
    } else {
      _password = ValidatedPassword(pwd);
      _passwordError = PasswordValidationError(null);
    }

    _changeLoginFormValid();
  }

  void changePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void _changeLoginFormValid () {
    if (email.value != null
        && password.value != null
    ) {
      _isLoginFormValid = true;
    } else {
      _isLoginFormValid = false;
    }

    notifyListeners();
  }

  void changeFreezeButtonColour () {
    _freezeButtonColour = !_freezeButtonColour;
    notifyListeners();
  }

  void clearLogin() {
    _email = ValidationItem(null, null);
    _password = ValidatedPassword(null);
    _passwordError = PasswordValidationError(null);
    _isPasswordVisible = false;
    _changeLoginFormValid();
    changeFreezeButtonColour();
  }

  void changeUserLoggedOut() {
    _userLoggedOut = true;
  }

}