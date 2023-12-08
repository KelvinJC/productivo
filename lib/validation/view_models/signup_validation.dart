import 'package:flutter/material.dart';
import 'package:todo/validation/models/validation_item.dart';
import 'package:todo/validation/models/password_validation.dart';


class SignupValidationViewModel extends ChangeNotifier {
  ValidationItem _name = ValidationItem(null, null);
  ValidationItem _email = ValidationItem(null, null);
  ValidationItem _phoneNumber = ValidationItem(null, null);
  ValidatedPassword _password = ValidatedPassword(null);
  ValidatedPassword _confirmPassword = ValidatedPassword(null);
  PasswordValidationError _passwordError = PasswordValidationError(null);
  PasswordValidationError _confirmPasswordError = PasswordValidationError(null);
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  // getters
  ValidationItem get name => _name;
  ValidationItem get email => _email;
  ValidationItem get phoneNumber => _phoneNumber;
  ValidatedPassword get password => _password;
  ValidatedPassword get confirmPassword => _confirmPassword;
  PasswordValidationError get passwordError => _passwordError;
  PasswordValidationError get confirmPasswordError => _confirmPasswordError;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  //setters
  void changeName(String val) {
    if (val.length >= 3) {
      _name = ValidationItem(val, null);
    } else {
      _name = ValidationItem(null, "Must be at least 3 characters");
    }
    notifyListeners();
  }

  void changePhoneNumber(String val) {
    if (val[0] != '0') {
      _phoneNumber = ValidationItem(null, "Invalid format (Hint: 08012345678)");
    } else if (val.length != 11) {
      _phoneNumber = ValidationItem(null, "Must be 11 characters");
    } else {
      _phoneNumber = ValidationItem(val, null);
    }
    notifyListeners();
  }

  void changeEmail(String val) {
    if (val.length >= 3) {
      _email = ValidationItem(val, null);
    } else {
      _email = ValidationItem(null, "Invalid format");
    }
    notifyListeners();
  }

  void enterPassword(String pwd) {
    _password = ValidatedPassword(pwd);
    confirmUserPassword(1, 0);
  }

  void confirmPasswordField(String pwd) {
    _confirmPassword = ValidatedPassword(pwd);
    confirmUserPassword(0, 1);
  }

  void confirmUserPassword(int p, int c) {
    if (c == 1) {
      if (password.value != confirmPassword.value) {
        _confirmPasswordError = PasswordValidationError("Passwords do not match");
      } else {
        _confirmPassword = ValidatedPassword(_confirmPassword.value!);
        _confirmPasswordError = PasswordValidationError(null);
      }
    }

    if (p == 1) {
      if (password.value!.length < 8) {
        _passwordError = PasswordValidationError("Password must be at least 8 characters long");
      } // check for uppercase
      else if (!RegExp(r'(?=.*[A-Z])').hasMatch(password.value!)) {
        _passwordError = PasswordValidationError("Password must contain one uppercase letter");
      } // check for lowercase
      else if (!RegExp(r'(?=.*[a-z])').hasMatch(password.value!)) {
        _passwordError = PasswordValidationError("Password must contain one lowercase letter");
      } // check for number
      else if (!RegExp(r'(?=.*\d)').hasMatch(password.value!)) {
        _passwordError = PasswordValidationError("Password must contain one number");
      }
      else if (confirmPassword.value != null && password.value != confirmPassword.value) {
        _passwordError = PasswordValidationError(null);
        _confirmPasswordError = PasswordValidationError("Passwords do not match");
      } else {
        _password = ValidatedPassword(password.value!);
        _passwordError = PasswordValidationError(null);
        _confirmPasswordError = PasswordValidationError(null);
      }
    }
    notifyListeners();
  }

  void changePasswordVisibility(String pwd) {
    if (pwd == 'pwd') {
      _isPasswordVisible = !_isPasswordVisible;
    } else {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    }

    notifyListeners();
  }
}