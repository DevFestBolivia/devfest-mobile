import 'package:firebase_auth/firebase_auth.dart';

abstract class EmailAuthRepository {
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password, Function userNotFound, Function wrongPassword);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String> getUser();
}