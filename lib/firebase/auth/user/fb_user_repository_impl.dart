import 'package:firebase_auth/firebase_auth.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user.dart';
import 'package:devfestbolivia/firebase/auth/user/fb_user_repository.dart';

class FbUserRepositoryImpl extends FbUserRepository {
  FbUser fbUser = FbUser();

  @override
  User? getCurrentUser() {
    return fbUser.getCurrentUser();
  }

  @override
  void forgotPassword(String email) {
    return fbUser.forgotPassword(email);
  }

  @override
  void logout() {
    return fbUser.logout();
  }
}
