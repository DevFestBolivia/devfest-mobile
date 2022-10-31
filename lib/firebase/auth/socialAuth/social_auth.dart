import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:devfestbolivia/models/social_user.dart';

class SocialAuth {
  Future<SocialUser> loginWithGoogle() async {
    SocialUser socialUser = SocialUser();

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/classroom.profile.photos',
      ],
    );

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    if (googleSignInAccount != null) {
      socialUser.displayName = googleSignInAccount.displayName;
      socialUser.email = googleSignInAccount.email;
      socialUser.photoUrl = googleSignInAccount.photoUrl;
      socialUser.serverAuthCode = googleSignInAccount.id;
      socialUser.success = true;
      print('test');
    }

    return socialUser;
  }
}
