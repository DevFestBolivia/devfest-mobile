import 'package:devfestbolivia/constants/custom_colors.dart';
import 'package:devfestbolivia/screens/components_screen.dart';
import 'package:devfestbolivia/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:devfestbolivia/firebase/firebase_main.dart';

import 'package:devfestbolivia/providers/counter.dart';

import 'package:devfestbolivia/screens/home_screen.dart';
import 'package:devfestbolivia/screens/speakers_screen.dart';

import 'package:devfestbolivia/screens/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseMain.initFirebase();

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Counter())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevFest 2022',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleSmall:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium:
              GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
          bodyMedium:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
          bodySmall:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
          headlineLarge: GoogleFonts.poppins(
              fontSize: 30, fontWeight: FontWeight.w600, color: CustomColors.mainButton),
          headlineSmall:
              GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.labelInput, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.labelInput, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder:OutlineInputBorder(
            borderSide: BorderSide(color: CustomColors.labelInput, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          fillColor: CustomColors.labelInput,
          labelStyle: TextStyle(fontSize: 12, color: CustomColors.labelInput),
          hintStyle: TextStyle(fontSize: 12, color: CustomColors.labelInput),
        ),
      ),
      initialRoute: Routes.LOGIN,
      routes: {
        Routes.COMPONENTS: (BuildContext context) => const ComponentsScreen(),
        Routes.LOGIN: (BuildContext context) => const LoginScreen(),
        Routes.HOME: (BuildContext context) => const HomeScreen(),
        Routes.SPEAKERS: (BuildContext context) => const SpeakersScreen(),
      },
    );
  }
}
