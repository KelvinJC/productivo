
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/models/status.dart';
import 'package:todo/auth/view_models/auth_view_model.dart';
import 'package:todo/validation/view_models/signup_validation.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  bool passwordMatch(String pwd, String confirmPwd) {
    if (pwd == confirmPwd) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    SignupValidationViewModel validationViewModel = context.watch<SignupValidationViewModel>();
    FirebaseAuthViewModel authViewModel = context.watch<FirebaseAuthViewModel>();
    String pwdVal;
    String confirmPwdVal;

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
                  'Hi there!',
                  style: GoogleFonts.montserrat(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                    'Let\'s get you on board.',
                    style: TextStyle(
                      fontSize: 15,
                    )
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person),
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
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onChanged: (String value) {
                      validationViewModel.changePhoneNumber(value);
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        errorText: validationViewModel.phoneNumber.error,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Mobile phone',
                        prefixIcon: Icon(Icons.phone),
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
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onChanged: (String val) {
                      validationViewModel.changeEmail(val.trim());
                    },
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^[a-zA-Z0-9_@.]+$'),
                      ),
                    ],
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
                SizedBox(height: 10,),
                // password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    obscureText: validationViewModel.isPasswordVisible,
                    onChanged: (String val) {
                      validationViewModel.enterPassword(val.trim());
                    },
                    decoration: InputDecoration(
                        errorText: validationViewModel.passwordError.error,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            validationViewModel.changePasswordVisibility('pwd');
                          },
                          child: Icon(
                              color: Colors.grey,
                              validationViewModel.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility
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
                SizedBox(height: 10,),
                // confirm password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFormField(
                    onChanged: (String val) {
                      validationViewModel.confirmPasswordField(val.trim());
                    },
                    obscureText: validationViewModel.isConfirmPasswordVisible,
                    decoration: InputDecoration(
                        errorText: validationViewModel.confirmPasswordError.error,
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Confirm password',
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            validationViewModel.changePasswordVisibility('confirm password');
                          },
                          child: Icon(
                              color: Colors.grey,
                              validationViewModel.isConfirmPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility
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
                    onTap: () {
                      pwdVal = validationViewModel.password.value!;
                      confirmPwdVal = validationViewModel.confirmPassword.value!;

                      if (pwdVal == confirmPwdVal) {
                        authViewModel.signUpWithEmailAndPassword(
                            validationViewModel.email.value!,
                            validationViewModel.password.value!
                        );
                      }
                      // else show error msg as snack pop or whatever it is called
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: authViewModel.status == Status.Registering
                            ? CircularProgressIndicator(color: Colors.white,)
                            : Text(
                            'Sign Up',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200]
                            )
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
                      'Already have an account?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      // onTap: widget.showRegisterPage,
                      child: Text(
                        ' Login',
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
