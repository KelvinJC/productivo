import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/view_models/auth_view_model.dart';
import 'package:todo/auth/views/signup_screen.dart';
import 'package:todo/homepage.dart';
import 'package:todo/splash_screen.dart';
import 'package:todo/todo_list/views/add_todo_screen.dart';
import '../models/status.dart';
import 'package:todo/auth/views/login_screen.dart';

class SwitchScreen extends StatelessWidget {
  const SwitchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuthViewModel authViewModel = context.watch<FirebaseAuthViewModel>();
    switch (authViewModel.status) {
      case Status.Authenticated:
        return AddTodoScreen();
      case Status.Unauthenticated:
        return LoginScreen();
      case Status.Authenticating:
        return LoginScreen(); //SplashScreen();
      case Status.Uninitialised:
        return Scaffold(
          body: Container(
              child: Text(
                'Uninitialised Screen!',
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.black
                ),
              )
          ),
        );
      // SplashScreen();
      default:
        return SignUpScreen();
    }
  }
}
