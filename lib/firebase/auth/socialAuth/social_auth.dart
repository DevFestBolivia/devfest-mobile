import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:devfestbolivia/models/social_user.dart';

class SocialAuth {
  Future<SocialUser> loginWithGoogle() async {
    SocialUser socialUser = SocialUser();

    GoogleSignIn googleSignIn = GoogleSignIn();

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {

    final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      socialUser.displayName = userCredential.user!.displayName;
      socialUser.email = userCredential.user!.email;
      socialUser.photoUrl = userCredential.user!.photoURL;
      socialUser.serverAuthCode = userCredential.user!.uid;
      socialUser.success = true;
      // print('test');
    }

    return socialUser;
  }
}
