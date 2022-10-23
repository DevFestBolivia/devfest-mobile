import 'package:devfestbolivia/firebase/auth/social_auth.dart';
import 'package:devfestbolivia/firebase/auth/social_auth_repository.dart';

class SocialAuthRepositoryImpl extends SocialAuthRepository {
  SocialAuth socialAuth = SocialAuth();

  @override
  Future<Map<String, Object?>> googleAuth() async {
    Map<String, Object?> result = await socialAuth.loginWithGoogle();
    return result;
  }

}