import 'package:flutter/material.dart';
import 'package:todo/auth/views/signup_screen.dart';

void openSignUpScreen(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SignUpScreen()
      )
  );
}

void openLoginScreenFromSignUpScreen(BuildContext context) {
  // NOTE: this function is only to be called from the SignUpScreen
  //
  // since the LoginScreen is below it on the stack
  // popping off the SignUpScreen will always navigate the user to the LoginScreen
  // This is done to avoid the edge case where
  // a user's repeated clicking of Login now and Register now
  // lead to a perpetual cycle of pushing routes upon each other
  try {
    Navigator.pop(context);
  } catch(e) {
    print(e);
  }


}