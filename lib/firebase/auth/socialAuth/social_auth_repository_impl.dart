import 'package:devfestbolivia/models/social_user.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth_repository.dart';

class SocialAuthRepositoryImpl extends SocialAuthRepository {
  SocialAuth socialAuth = SocialAuth();

  @override
  Future<SocialUser> googleAuth() async {
    SocialUser result = await socialAuth.loginWithGoogle();
    return result;
  }
}