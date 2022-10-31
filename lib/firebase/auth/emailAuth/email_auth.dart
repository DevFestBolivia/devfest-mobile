import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  Future<UserCredential?> loginWithEmailAndPassword(
      String email, String password, Function userNotFound, Function wrongPassword) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        userNotFound();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        wrongPassword();
      }
    }
    return null;
  }
}
