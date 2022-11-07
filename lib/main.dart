import 'package:devfestbolivia/firebase/auth/user/fb_user_repository_impl.dart';
import 'package:devfestbolivia/providers/auth_provider.dart';
import 'package:devfestbolivia/screens/google_developer_groups_screen.dart';
import 'package:devfestbolivia/screens/places_screen.dart';
import 'package:devfestbolivia/screens/profile_screen.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/utils/validator_util.dart';
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

import 'firebase/attendees/attendees_repository_impl.dart';
import 'firebase/auth/emailAuth/email_auth_repository_impl.dart';
import 'firebase/auth/socialAuth/social_auth_repository_impl.dart';
import 'firebase/functions/functions_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseMain.initFirebase();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => AttendeesProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            fbUserRepository: FbUserRepositoryImpl(),
            emailAuthRepository: EmailAuthRepoitoryImpl(),
            socialAuthRepository: SocialAuthRepositoryImpl(),
            fbFunctionsRepository: FunctionsRepositoryImpl(),
            attendeesRepository: AttendeesRepositoryImpl(),
            validatorUtil: ValidatorUtil(),
          ),
        )
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: DevFestColors.primaryLight,
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          titleSmall:
              GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
          titleMedium:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: DevFestColors.textBlack.withOpacity(0.12), width: 1.0),
            borderRadius:
                const BorderRadius.all(Radius.circular(SpacingValues.xs)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: DevFestColors.textBlack.withOpacity(0.12), width: 1.0),
            borderRadius:
                const BorderRadius.all(Radius.circular(SpacingValues.xs)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: DevFestColors.textBlack.withOpacity(0.12), width: 1.0),
            borderRadius:
                const BorderRadius.all(Radius.circular(SpacingValues.xs)),
          ),
          fillColor: DevFestColors.labelInput,
          labelStyle:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
          hintStyle:
              GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w400),
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
        Routes.PROFILE: (BuildContext _) => const ProfileScreen(),
        Routes.PLACES: (BuildContext _) => const PlacesScreen(),
        Routes.GDG: (BuildContext _) => const GoogleDeveloperGroupsScreen(),
      },
    );
  }
}
