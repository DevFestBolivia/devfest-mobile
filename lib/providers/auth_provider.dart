import 'package:devfestbolivia/firebase/attendees/attendees_repository.dart';
import 'package:devfestbolivia/firebase/auth/emailAuth/email_auth_repository.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth_repository.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository.dart';
import 'package:devfestbolivia/firebase/functions/functions_repository.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/social_user.dart';
import 'package:devfestbolivia/text_strings.dart';
import 'package:devfestbolivia/utils/validator_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required FbUserRepository fbUserRepository,
    required EmailAuthRepository emailAuthRepository,
    required SocialAuthRepository socialAuthRepository,
    required FunctionsRepository fbFunctionsRepository,
    required AttendeesRepository attendeesRepository,
    required ValidatorUtil validatorUtil,
  })  : _fbUserRepository = fbUserRepository,
        _emailAuthRepository = emailAuthRepository,
        _socialAuthRepository = socialAuthRepository,
        _fbFunctionsRepository = fbFunctionsRepository,
        _attendeesRepository = attendeesRepository,
        _validatorUtil = validatorUtil;

  final FbUserRepository _fbUserRepository;
  final EmailAuthRepository _emailAuthRepository;
  final SocialAuthRepository _socialAuthRepository;
  final FunctionsRepository _fbFunctionsRepository;
  final AttendeesRepository _attendeesRepository;
  final ValidatorUtil _validatorUtil;

  String _email = '';
  String _password = '';

  bool loginButtonEnabled = false;

  void setEmail(String email) {
    _email = email;
    _validateCurrentCredentials();
  }

  void setPassword(String password) {
    _password = password;
    _validateCurrentCredentials();
  }

  void _validateCurrentCredentials() {
    final emailValidatorResult = _validatorUtil.validateEmail(_email);
    final passwordValidatorResult = _validatorUtil.validatePassword(_password);

    if (emailValidatorResult.isValid && passwordValidatorResult.isValid) {
      loginButtonEnabled = true;
      notifyListeners();
    } else {
      loginButtonEnabled = false;
      notifyListeners();
    }
  }

  Future<Attendees> loginWithEmailAndPassword({
    required VoidCallback onUserNotFoundCallback,
    required VoidCallback onWrongPasswordCallback,
  }) async {
    try {
      late Attendees attendees;
      late User user;
      UserCredential userCredential =
          await _emailAuthRepository.signInWithEmailAndPassword(
        _email,
        _password,
        onUserNotFoundCallback,
        onWrongPasswordCallback,
      );

      if (userCredential.user != null) {
        user = userCredential.user!;
        attendees = await _attendeesRepository.getAttendeesById(user.uid);
        return attendees;
      }

      throw Exception('Error no esperado');
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginWithGoogleResponse> loginWithGoogle() async {
    try {
      SocialUser socialUser = await _socialAuthRepository.googleAuth();
      final attendees =
          await _attendeesRepository.getAttendeesByEmail(socialUser.email!);
      return LoginWithGoogleResponse(
        attendees: attendees,
        socialUser: socialUser,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> forgotPassword(String email) async {
    _fbUserRepository.forgotPassword(email);
  }
}

class LoginWithGoogleResponse {
  LoginWithGoogleResponse({
    required this.attendees,
    required this.socialUser,
  });

  final Attendees attendees;
  final SocialUser socialUser;
}
