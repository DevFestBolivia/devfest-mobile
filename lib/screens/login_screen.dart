import 'package:devfestbolivia/widgets/dialogs/loading_dialog.dart';
import 'package:flutter/material.dart';

import 'package:devfestbolivia/firebase/auth/social_auth_repository.dart';
import 'package:devfestbolivia/firebase/auth/social_auth_repository_impl.dart';
import 'package:devfestbolivia/widgets/main_outlined_button.dart';
import 'package:devfestbolivia/constants/custom_colors.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/widgets/section_divider.dart';
import 'package:devfestbolivia/widgets/TextLink.dart';
import 'package:devfestbolivia/widgets/main_button.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:devfestbolivia/widgets/local_image.dart';
import 'package:devfestbolivia/widgets/input_email.dart';
import 'package:devfestbolivia/widgets/input_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SocialAuthRepository? socialAuthRepository;
  bool loading = true;
  bool loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    loadReferences();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            renderLogo(),
            const InputEmail(leftMargin: 20, rightMargin: 20, topMargin: 20),
            const InputPassword(leftMargin: 20, rightMargin: 20, topMargin: 40),
            const SizedBox(height: 20),
            renderForgotPassword(),
            MainButton(
                text: TextStrings.logIn, topMargin: 15, onPressed: login),
            const SectionDivider(height: 40),
            renderSecondaryMessage(),
            MainOutlinedButton(
              text: TextStrings.createAccount,
              onPressed: createAccount,
              topMargin: 15,
              marginText: 20,
            )
          ],
        ),
      ),
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
      colorText: CustomColors.disableText,
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

  void loadReferences() {
    if (!loading) {
      return;
    }

    socialAuthRepository = SocialAuthRepositoryImpl();
    setState(() {
      loading = false;
    });
  }

  void setLoginInProgress(bool value) {
    setState(() {
      loginInProgress = value;
    });
    if(value) {
      Dialogs.showLoadingDialog(context);
    } else {
      Dialogs.hideLoadingDialog(context);
    }
  }

  void login() async {
    print('login');
    setLoginInProgress(true);
    try {
      Map<String, Object?>? googleAuth = await socialAuthRepository?.googleAuth();
    } catch (e) {
      print(e);
    } finally {
      setLoginInProgress(false);
    }
  }

  void forgotPassword() {
    print('Forgot Password');
  }

  void createAccount() {
    print('Create Account');
  }
}
