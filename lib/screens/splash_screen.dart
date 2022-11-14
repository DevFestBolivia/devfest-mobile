import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:devfestbolivia/screens/routes.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/widgets/local_image.dart';
import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/providers/attendees_provider.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_repository.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository_impl.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_repository_impl.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FbUserRepository? fbUserRepository;
  AttendeesRepository? attendeesRepository;
  bool loading = true;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadingReferences(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: const [
              LocalImage(
                pathImage: AssetsPath.logoPng,
                horizontalMargin: 20,
                verticalMargin: 30,
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void loadingReferences(BuildContext context) {
    if (!loading) {
      return;
    }

    setState(() {
      fbUserRepository = FbUserRepositoryImpl();
      attendeesRepository = AttendeesRepositoryImpl();
      loading = false;
    });
    getCurrentUser();
  }

  void getCurrentUser() async {
    User? currentUser = fbUserRepository!.getCurrentUser();
    if (currentUser != null) {
      Attendees attendeess =
          await attendeesRepository!.getAttendeesById(currentUser.uid);
      changeAttendeesCurrentUser(attendeess);
    } else {
      Navigator.pushReplacementNamed(context, Routes.LOGIN);
    }
  }

  void changeAttendeesCurrentUser(Attendees? attendees) {
    if (attendees != null) {
      AttendeesProvider attendeesProvider = Provider.of<AttendeesProvider>(context, listen: false);
      attendeesProvider.setCurrentUser(attendees);
      Navigator.pushReplacementNamed(context, Routes.HOME);
    } else {
      Navigator.pushReplacementNamed(context, Routes.LOGIN);
    }
  }
}
