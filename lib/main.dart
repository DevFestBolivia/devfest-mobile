import 'package:devfestbolivia/screens/components_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:devfestbolivia/firebase/firebase_main.dart';

import 'package:devfestbolivia/providers/counter.dart';

import 'package:devfestbolivia/my_home_page.dart';
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
          titleSmall: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
          bodyMedium: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
          bodySmall: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400),
          headlineLarge: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.blue),
          headlineSmall: GoogleFonts.raleway(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      initialRoute: Routes.COMPONENTS,
      routes: {
        Routes.COMPONENTS: (BuildContext context) => const ComponentsScreen(),
        Routes.HOME: (BuildContext context) => const MyHomePage(),
        Routes.SPEAKERS: (BuildContext context) => const SpeakersScreen(),
      },
    );
  }
}
