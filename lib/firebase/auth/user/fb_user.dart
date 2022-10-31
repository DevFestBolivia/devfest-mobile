import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbUser extends CloudFireStore {
  User? getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      print('user is not null');
    } else {
      print('user is null');
    }
    return user;
  }

  void forgotPassword(String email) {
    print('ForgotPassword:: $email');
    try {
      auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  void logout() {
    auth.signOut();
  }
}
