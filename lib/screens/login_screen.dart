import 'package:devfestbolivia/providers/auth_provider.dart';
import 'package:devfestbolivia/style/spacing.dart';
import 'package:devfestbolivia/utils/validator_util.dart';
import 'package:flutter/material.dart';

import 'package:devfestbolivia/widgets/text_link.dart';
import 'package:devfestbolivia/widgets/main_text.dart';
import 'package:devfestbolivia/widgets/local_image.dart';
import 'package:devfestbolivia/widgets/section_divider.dart';
import 'package:devfestbolivia/widgets/main_outlined_button.dart';
import 'package:devfestbolivia/widgets/dialogs/error_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/loading_dialog.dart';
import 'package:devfestbolivia/widgets/dialogs/forgot_password_dialog.dart';

import 'package:devfestbolivia/screens/routes.dart';

import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/style/devfest_colors.dart';
import 'package:devfestbolivia/constants/assets_path.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:devfestbolivia/providers/attendees_provider.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository_impl.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_repository_impl.dart';
import 'package:devfestbolivia/firebase/functions/functions_repository_impl.dart';
import 'package:devfestbolivia/firebase/auth/emailAuth/email_auth_repository_impl.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth_repository_impl.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingValues.xl,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  renderLogo(),
                  Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          label: Text(
                            'Email',
                          ),
                        ),
                        onChanged: (email) =>
                            Provider.of<AuthProvider>(context, listen: false)
                                .setEmail(email),
                      ),
                      VerticalSpacing.xxl,
                      TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text(
                            'Password',
                          ),
                        ),
                        onChanged: (password) =>
                            Provider.of<AuthProvider>(context, listen: false)
                                .setPassword(password),
                      )
                    ],
                  ),

                  // InputEmail(
                  //   leftMargin: 20,
                  //   rightMargin: 20,
                  //   topMargin: 20,
                  //   onChanged: onChangeEmail,
                  //   formKey: _formKey,
                  // ),
                  // InputPassword(
                  //   leftMargin: 20,
                  //   rightMargin: 20,
                  //   topMargin: 40,
                  //   onChanged: onChangePassword,
                  //   formKey: _formPasswordKey,
                  // ),
                  const SizedBox(height: 20),
                  renderForgotPassword(),
                  const SizedBox(
                    height: SpacingValues.xl * 2,
                  ),
                  renderLoginButton(),
                  VerticalSpacing.m,
                  renderGoogleButton(),
                  // renderCreateAccountSection(),
                ],
              ),
            ),
          );
        },
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
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return ElevatedButton(
          onPressed: authProvider.loginButtonEnabled ? _login : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              authProvider.loginButtonEnabled
                  ? DevFestColors.primary
                  : Colors.grey.shade400,
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: SpacingValues.l,
            ),
            child: Text(
              TextStrings.logIn.toUpperCase(),
              style: const TextStyle(
                color: DevFestColors.primaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
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
        activateUnderline: true,
        onPressed: _showforgotPasswordDialog,
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
      decoration: BoxDecoration(
          border: Border.all(color: DevFestColors.textBlack.withOpacity(0.12))),
      child: SocialLoginButton(
        text: 'Continuar con Google',
        buttonType: SocialLoginButtonType.google,
        onPressed: () async {
          try {
            await _loginWithGoogle(context);
            _goToOnboarding();
          } catch (e) {
            ErrorDialog.showErrorDialog(
              context,
              TextStrings.anErrorOccurredTryAgain,
            );
          }
        },
        // onPressed: loginWithGoogle,
      ),
    );
  }

  Future<void> _loginWithGoogle(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Dialogs.showLoadingDialog(context);
      await authProvider.loginWithGoogle();
      // ignore: use_build_context_synchronously
      Dialogs.hideLoadingDialog(context);
    } catch (e) {
      Dialogs.hideLoadingDialog(context);
      rethrow;
    }
  }

  void _goToOnboarding() {
    Navigator.pushReplacementNamed(context, Routes.ONBOARDING);
  }

  void _goToHome() {
    Navigator.pushReplacementNamed(context, Routes.HOME);
  }

  void _showforgotPasswordDialog(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    ForgotPasswordDialog.showForgotPasswordDialog(
      context,
      authProvider.forgotPassword,
    );
  }

  void createAccount() {
    print('Create Account');
  }

  void _login() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      Dialogs.showLoadingDialog(context);
      final attendees = await authProvider.loginWithEmailAndPassword(
        onUserNotFoundCallback: showUserNotFoundMessage,
        onWrongPasswordCallback: showWrongPasswordMessage,
      );
      _setUser(attendees);
      // ignore: use_build_context_synchronously
      Dialogs.hideLoadingDialog(context);
      _goToHome();
    } catch (e) {
      Dialogs.hideLoadingDialog(context);
      ErrorDialog.showErrorDialog(
        context,
        TextStrings.anErrorOccurredTryAgain,
      );
    }
  }

  void _setUser(Attendees attendees) {
    final attendeesProvider =
        Provider.of<AttendeesProvider>(context, listen: false);
    attendeesProvider.setCurrentUser(attendees);
  }

  void showUserNotFoundMessage() {
    ErrorDialog.showUserNotFoundDialog(context);
  }

  void showWrongPasswordMessage() {
    ErrorDialog.showWrongPasswordDialog(context);
  }
}
