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
    if (googleSignInAccount != null) {
      socialUser.displayName = googleSignInAccount.displayName;
      socialUser.email = googleSignInAccount.email;
      socialUser.photoUrl = googleSignInAccount.photoUrl;
      socialUser.serverAuthCode = googleSignInAccount.serverAuthCode;
      socialUser.success = true;
      print('test');
    }

    return socialUser;
  }
}
