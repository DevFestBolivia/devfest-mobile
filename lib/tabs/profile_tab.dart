import 'package:flutter/material.dart';
import 'package:devfestbolivia/screens/routes.dart';
import 'package:devfestbolivia/widgets/main_button.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository_impl.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  FbUserRepository? fbUserRepository;
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    loadReferences();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile'),
            MainButton(onPressed: () => logout(), text: 'Logout'),
          ],
        ),
      ),
    );
  }

  void loadReferences() {
    if (!loading) {
      return;
    }

    setState(() {
      fbUserRepository = FbUserRepositoryImpl();
      loading = false;
    });
  }

  void logout() {
    fbUserRepository!.logout();
    Navigator.pushReplacementNamed(context, Routes.LOGIN);
  }
}
