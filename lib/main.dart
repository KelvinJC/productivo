import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/view_models/auth_view_model.dart';
import 'package:todo/auth/views/switch_screen.dart';
import 'package:todo/components/calendar/view_models/calendar_view_model.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/event_list/view_models/category_view_model.dart';
import 'package:todo/event_list/view_models/location_view_model.dart';
import 'package:todo/event_list/view_models/event_view_model.dart';
import 'package:todo/validation/view_models/login_validation.dart';
import 'package:todo/validation/view_models/signup_validation.dart';

import 'components/clock/view_models/clock_view_model.dart';
import 'event_list/repo/event.dart';
import '../../db/database.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // check that db tables are created
  await DB.checkDatabaseCreation();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // get access to database
    DB db = DB.instance;

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
        ChangeNotifierProvider<EventViewModel>(
            create: (_) => EventViewModel(EventRepository(db))
        ),
        ChangeNotifierProvider<CalendarViewModel>(
            create: (_) => CalendarViewModel()
        ),
        ChangeNotifierProvider<CategoryViewModel>(
            create: (_) => CategoryViewModel()
        ),
        ChangeNotifierProvider<LocationViewModel>(
            create: (_) => LocationViewModel()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white70,),
          useMaterial3: true,
        ),
        home: const SwitchScreen(),
      ),
    );
  }
}
