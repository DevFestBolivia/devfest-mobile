import 'package:google_sign_in/google_sign_in.dart';

class SocialAuth {
  Future<Map<String, Object?>> loginWithGoogle() async {
    String? displayName;
    String? email;
    String? photoUrl;
    String? serverAuthCode;
    bool success = false;

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/classroom.profile.photos',
      ],
    );

    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      displayName = googleSignInAccount.displayName;
      email = googleSignInAccount.email;
      photoUrl = googleSignInAccount.photoUrl;
      serverAuthCode = googleSignInAccount.serverAuthCode;
      success = true;
      print('test');
    }

    return {
      'success': success,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'serverAuthCode': serverAuthCode
    };
  }
}
