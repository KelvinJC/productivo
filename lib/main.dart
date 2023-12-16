import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/view_models/auth_view_model.dart';
import 'package:todo/auth/views/switch_screen.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/homepage.dart';
import 'package:todo/validation/view_models/login_validation.dart';
import 'package:todo/validation/view_models/signup_validation.dart';

import 'clock/view_models/clock_view_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthViewModel>(
            create: (_) => FirebaseAuthViewModel()
        ),
        ChangeNotifierProvider<SignupValidationViewModel>(
            create: (_) => SignupValidationViewModel()
        ),
        ChangeNotifierProvider<LoginValidationViewModel>(
            create: (_) => LoginValidationViewModel()
        ),
        ChangeNotifierProvider<ClockViewModel>(
            create: (_) => ClockViewModel()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70, primary: Colors.black54),
          useMaterial3: true,
        ),
        home: const SwitchScreen(),
      ),
    );
  }
}
