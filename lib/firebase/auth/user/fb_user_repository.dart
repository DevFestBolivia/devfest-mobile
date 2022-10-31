import 'package:firebase_auth/firebase_auth.dart';

abstract class FbUserRepository {
  User? getCurrentUser();
  void forgotPassword(String email);
  void logout();
}
