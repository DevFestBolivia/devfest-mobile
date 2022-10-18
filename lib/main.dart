import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:devfestbolivia/firebase/firebase_main.dart';

import 'package:devfestbolivia/providers/counter.dart';

import 'package:devfestbolivia/my_home_page.dart';
import 'package:devfestbolivia/screens/speakers_page.dart';

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
      ),
      initialRoute: Routes.HOME,
      routes: {
        Routes.HOME: (BuildContext context) => const MyHomePage(),
        Routes.SPEAKERS: (BuildContext context) => const SpeakersPage(),
      },
    );
  }
}
