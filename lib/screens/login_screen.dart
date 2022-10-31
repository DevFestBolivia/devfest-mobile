import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:devfestbolivia/widgets/text_link.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/widgets/main_button.dart';
import 'package:devfestbolivia/widgets/local_image.dart';
import 'package:devfestbolivia/widgets/input_email.dart';
import 'package:devfestbolivia/widgets/input_password.dart';
import 'package:devfestbolivia/widgets/section_divider.dart';
import 'package:devfestbolivia/widgets/main_outlined_button.dart';
import 'package:devfestbolivia/widgets/dialogs/error_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/loading_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/forgot_password_dialog.dart';

import 'package:devfestbolivia/screens/routes.dart';

import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/social_user.dart';
import 'package:devfestbolivia/utils/validator_util.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:devfestbolivia/providers/attendees_provider.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_repository.dart';
import 'package:devfestbolivia/firebase/functions/functions_repository.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository_impl.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_repository_impl.dart';
import 'package:devfestbolivia/firebase/functions/functions_repository_impl.dart';
import 'package:devfestbolivia/firebase/auth/emailAuth/email_auth_repository.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth_repository.dart';
import 'package:devfestbolivia/firebase/auth/emailAuth/email_auth_repository_impl.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FbUserRepository? fbUserRepository;
  EmailAuthRepository? emailAuth;
  SocialAuthRepository? socialAuthRepository;
  FunctionsRepository? fbFunctionsRepository;
  AttendeesRepository? attendeesRepository;
  final AttendeesProvider attendeesProvider = AttendeesProvider();

  final _formKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  bool loading = true;
  BuildContext? _context;
  bool loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    loadReferences(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            renderLogo(),
            InputEmail(
              leftMargin: 20,
              rightMargin: 20,
              topMargin: 20,
              onChanged: onChangeEmail,
              formKey: _formKey,
            ),
            InputPassword(
              leftMargin: 20,
              rightMargin: 20,
              topMargin: 40,
              onChanged: onChangePassword,
              formKey: _formPasswordKey,
            ),
            const SizedBox(height: 20),
            renderForgotPassword(),
            renderLoginButton(),
            renderGoogleButton(),
            // renderCreateAccountSection(),
          ],
        ),
      ),
    );
  }

  Widget renderCreateAccountSection() {
    return Column(
      children: [
        const SectionDivider(height: 40),
        renderSecondaryMessage(),
        renderCreateAccountButton(),
      ],
    );
  }

  Widget renderLoginButton() {
    return MainButton(
      text: TextStrings.logIn,
      topMargin: 15,
      onPressed: login,
    );
  }

  Widget renderCreateAccountButton() {
    return MainOutlinedButton(
      text: TextStrings.createAccount,
      onPressed: createAccount,
      topMargin: 15,
      marginText: 20,
    );
  }

  Widget renderForgotPassword() {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(right: 20),
      child: TextLink(
        firstText: TextStrings.youForgot,
        linkText: '${TextStrings.passwordES}?',
        onPressed: forgotPassword,
      ),
    );
  }

  Widget renderSecondaryMessage() {
    return const MainText(
      text: '${TextStrings.doNotYouHaveAndAccountYet}?',
      leftMargin: 20,
      rightMargin: 20,
      topMargin: 0,
      bottomMargin: 0,
      colorText: DevFestColors.disableText,
    );
  }

  Widget renderLogo() {
    return const Center(
      child: LocalImage(
        pathImage: AssetsPath.logoPng,
        horizontalMargin: 20,
        verticalMargin: 30,
      ),
    );
  }

  Widget renderGoogleButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: SocialLoginButton(
        buttonType: SocialLoginButtonType.google,
        onPressed: loginWithGoogle,
      ),
    );
  }

  void loadReferences(BuildContext context) {
    if (!loading) {
      return;
    }

    setState(() {
      emailAuth = EmailAuthRepoitoryImpl();
      socialAuthRepository = SocialAuthRepositoryImpl();
      fbFunctionsRepository = FunctionsRepositoryImpl();
      fbUserRepository = FbUserRepositoryImpl();
      attendeesRepository = AttendeesRepositoryImpl();
      _context = context;
      loading = false;
    });
  }

  void setLoginInProgress(bool value) {
    setState(() {
      loginInProgress = value;
    });
    if (value) {
      Dialogs.showLoadingDialog(_context!);
    } else {
      Dialogs.hideLoadingDialog(_context!);
    }
  }

  loginWithGoogle() async {
    setLoginInProgress(true);
    try {
      SocialUser? socialUser = await fbFunctionsRepository?.loginWithGoogle();
      changeCurrentUser(socialUser);
    } catch (e) {
      setLoginInProgress(false);
      ErrorDialog.showErrorDialog(
          _context!, TextStrings.anErrorOccurredTryAgain);
      print(e);
    }
  }

  void changeCurrentUser(SocialUser? socialUser) {
    if (socialUser != null) {
      setLoginInProgress(false);
      nextScreen();
    }
  }

  void nextScreen() {
    Navigator.pushReplacementNamed(_context!, Routes.ONBOARDING);
  }

  void forgotPassword() {
    print('Forgot Password');
    ForgotPasswordDialog.showForgotPasswordDialog(
        _context!, fbUserRepository!.forgotPassword);
  }

  void createAccount() {
    print('Create Account');
  }

  void onChangeEmail(String email) {
    setState(() {
      this.email = email;
    });
  }

  void onChangePassword(String password) {
    setState(() {
      this.password = password;
    });
  }

  void login() async {
    setLoginInProgress(true);
    _formKey.currentState!.validate();
    _formPasswordKey.currentState!.validate();
    try {
      if (ValidatorUtil.validateEmail(email).isValid &&
          ValidatorUtil.validatePassword(password).isValid) {
        UserCredential? userCredential = await changeUserCredential();
        print('UserCredential ${userCredential?.user?.uid}');
        User? user = await changeUser(userCredential);
        print('User ${user?.uid}');
        Attendees? attendees = await changeAttendees(user);
        print('Attendees ${attendees}');
        changeAttendeesCurrentUser(attendees);
      } else {
        setLoginInProgress(false);
      }
    } catch (e) {
      setLoginInProgress(false);
      ErrorDialog.showErrorDialog(
          _context!, TextStrings.anErrorOccurredTryAgain);
      print('login error: $e');
    }
  }

  Future<UserCredential?> changeUserCredential() async {
    UserCredential? userCredential =
        await emailAuth?.signInWithEmailAndPassword(
            email, password, showUserNotFoundMessage, showWrongPasswordMessage);

    return userCredential;
  }

  Future<User?> changeUser(UserCredential? userCredential) async {
    if (userCredential != null) {
      User? user = userCredential.user;
      if (user != null) {}
      return user!;
    }

    return null;
  }

  Future<Attendees?> changeAttendees(User? user) async {
    if (user != null) {
      print('User ${user.uid}');
      Attendees attendees =
          await attendeesRepository!.getAttendeesById(user.uid);
      print('Attendees ${attendees.id}');
      return attendees;
    }
    return null;
  }

  void changeAttendeesCurrentUser(Attendees? attendees) {
    if (attendees != null) {
      print('Attendees:: ${attendees.id}');
      attendeesProvider.setCurrentUser(attendees);
      setLoginInProgress(false);
      Navigator.pushReplacementNamed(_context!, Routes.HOME);
    } else {
      setLoginInProgress(false);
      Navigator.pushReplacementNamed(_context!, Routes.LOGIN);
    }
  }

  void showUserNotFoundMessage() {
    ErrorDialog.showUserNotFoundDialog(_context!);
  }

  void showWrongPasswordMessage() {
    ErrorDialog.showWrongPasswordDialog(_context!);
  }
}
