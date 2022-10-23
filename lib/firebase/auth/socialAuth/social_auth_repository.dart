import 'package:devfestbolivia/models/social_user.dart';

abstract class SocialAuthRepository {
  Future<SocialUser> googleAuth();
}