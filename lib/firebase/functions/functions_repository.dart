import '../../models/social_user.dart';

abstract class FunctionsRepository {
  Future<SocialUser> loginWithGoogle();
}