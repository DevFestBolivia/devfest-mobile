import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/utils/printUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbUser extends CloudFireStore {
  User? getCurrentUser() {
    final user = auth.currentUser;
    if (user != null) {
      PrintUtil.debugPrint('user is not null');
    } else {
      PrintUtil.debugPrint('user is null');
    }
    return user;
  }

  void forgotPassword(String email) {
    PrintUtil.debugPrint('ForgotPassword:: $email');
    try {
      auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      PrintUtil.debugPrint(e.toString());
    }
  }

  void logout() {
    auth.signOut();
  }
}
