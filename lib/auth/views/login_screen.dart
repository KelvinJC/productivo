import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/view_models/auth_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/validation/view_models/login_validation.dart';
import 'package:todo/routing/navigation.dart';
import '../models/status.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuthViewModel authViewModel = context.watch<FirebaseAuthViewModel>();
    LoginValidationViewModel validationViewModel = context.watch<LoginValidationViewModel>();
    bool loginFormValid = validationViewModel.isLoginFormValid;
    bool freezeButtonColour = validationViewModel.freezeButtonColour;
    bool userLoggedOut = validationViewModel.userLoggedOut;


    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/checklist.svg',
                  // semanticsLabel: 'My SVG Image',
                  height: 100,
                  width: 70,
                  color: Colors.black,
                ),
                SizedBox(height: 25,),
                Text(
                  'Hello again!',
                  style: GoogleFonts.montserrat(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  userLoggedOut
                    ? 'Let\'s get you in shall we?'
                    : 'Welcome back, you\'ve been missed.',
                  style: TextStyle(fontSize: 17,)
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onChanged: (String val) {
                      validationViewModel.changeEmail(val.trim());
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white70
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white70
                          ),
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onChanged: (String val) {
                      validationViewModel.changePassword(val.trim());
                    },
                    obscureText: !validationViewModel.isPasswordVisible,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            validationViewModel.changePasswordVisibility();
                          },
                          child: Icon(
                            color: Colors.grey,
                            validationViewModel.isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white70
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1,
                              color: Colors.white70
                          ),
                          borderRadius: BorderRadius.circular(30),
                        )
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () async {
                      if (loginFormValid) {
                       bool login = await authViewModel.signInWithEmailAndPassword(
                          validationViewModel.email.value!,
                          validationViewModel.password.value!
                         );
                       validationViewModel.changeFreezeButtonColour();
                       validationViewModel.clearLogin();
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: loginFormValid || freezeButtonColour ? Colors.black : Colors.grey[400],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: authViewModel.status == Status.Authenticating
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                            'Sign In',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200]
                            ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        openSignUpScreen(context);
                      },
                      child: Text(
                        ' Register now',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
