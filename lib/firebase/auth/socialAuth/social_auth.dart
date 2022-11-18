import 'package:devfestbolivia/utils/printUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:devfestbolivia/models/social_user.dart';
import 'package:http/http.dart' as http;

class SocialAuth {
  Future<SocialUser> loginWithGoogle() async {
    SocialUser socialUser = SocialUser();

    GoogleSignIn googleSignIn = kIsWeb
        ? GoogleSignIn(
            clientId:
                '328093322585-306h4kd068s7fvgda156pj7ks8k1sq8a.apps.googleusercontent.com')
        : GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      String googleEmail = googleSignInAccount.email;
      PrintUtil.debugPrint('googleEmail: $googleEmail');
      // var result = await userExists(googleEmail);

      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      socialUser.displayName = userCredential.user!.displayName;
      socialUser.email = userCredential.user!.email;
      socialUser.photoUrl = userCredential.user!.photoURL;
      socialUser.serverAuthCode = userCredential.user!.uid;
      socialUser.success = true;
    } else {
      socialUser.success = false;
    }

    return socialUser;
  }

  Future<void> userExists(String email) async {
    var url = Uri.https(
        'https://us-central1-devfest-bolivia-2022.cloudfunctions.net/userExistsByEmail');
    var response = await http.post(url, body: {'email': email});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
