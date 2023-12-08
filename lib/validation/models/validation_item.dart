class ValidationItem {
  final String? value;
  final String? error;

  ValidationItem(this.value, this.error);
}

class ValidatedPassword {
  final String? value;

  ValidatedPassword(this.value);
}

class PasswordValidationError {
  final String? error;

  PasswordValidationError(this.error);
}

// void confirmPasswordField(String pwd) {
//   if (pwd.length < 8
//       && !RegExp(r'(?=.*[A-Z])').hasMatch(pwd)
//       && !RegExp(r'(?=.*[a-z])').hasMatch(pwd)
//       && !RegExp(r'(?=.*\d)').hasMatch(pwd)
//   ) {
//     _confirmPassword = ValidationItem(pwd, null);
//   }
// }