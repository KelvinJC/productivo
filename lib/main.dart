import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/view_models/auth_view_model.dart';
import 'package:todo/auth/views/switch_screen.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/homepage.dart';
import 'package:todo/validation/signup_validation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SwitchScreen(),
      ),
    );
  }
}
