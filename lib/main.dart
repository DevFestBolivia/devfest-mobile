import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:devfestbolivia/screens/routes.dart';
import 'package:devfestbolivia/screens/login_screen.dart';
import 'package:devfestbolivia/screens/camera_screen.dart';
import 'package:devfestbolivia/screens/splash_screen.dart';
import 'package:devfestbolivia/screens/speakers_screen.dart';
import 'package:devfestbolivia/screens/home/home_screen.dart';
import 'package:devfestbolivia/screens/onboarding_screen.dart';
import 'package:devfestbolivia/screens/components_screen.dart';
import 'package:devfestbolivia/screens/task_details_screen.dart';

import 'package:devfestbolivia/providers/counter.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/firebase/firebase_main.dart';
import 'package:devfestbolivia/providers/attendees_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseMain.initFirebase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => AttendeesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevFest 2022',
      theme: ThemeData(
        scaffoldBackgroundColor: DevFestColors.primaryLight,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleSmall:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium:
              GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
          bodyLarge:
              GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
          bodyMedium:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
          bodySmall:
              GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
          headlineLarge: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: DevFestColors.primary,
          ),
          headlineMedium: GoogleFonts.raleway(
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
            color: DevFestColors.textBlack,
          ),
          headlineSmall:
              GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(0.0),
            backgroundColor: MaterialStatePropertyAll(DevFestColors.primary),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: DevFestColors.labelInput, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DevFestColors.labelInput, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: DevFestColors.labelInput, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          fillColor: DevFestColors.labelInput,
          labelStyle: TextStyle(fontSize: 12, color: DevFestColors.labelInput),
          hintStyle: TextStyle(fontSize: 12, color: DevFestColors.labelInput),
        ),
      ),
      initialRoute: Routes.SPLASH,
      routes: {
        Routes.SPLASH: (context) => const SplashScreen(),
        Routes.LOGIN: (BuildContext context) => const LoginScreen(),
        Routes.HOME: (BuildContext context) => const HomeScreen(),
        Routes.SPEAKERS: (BuildContext context) => const SpeakersScreen(),
        Routes.ONBOARDING: (BuildContext context) => const OnboardingScreen(),
        Routes.COMPONENTS: (BuildContext context) => const ComponentsScreen(),
        Routes.TASK_DETAILS: (BuildContext context) => const TaskDetailsScreen(
              session: null,
              startTime: null,
              endTime: null,
            ),
        Routes.CAMERA: (BuildContext context) => const CameraScreen(),
      },
    );
  }
}
