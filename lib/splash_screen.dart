import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: Text(
              'Splash Screen',
              style: GoogleFonts.montserrat(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              )
          ),
        ),
      ),
    );
  }
}
