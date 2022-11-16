import 'package:devfestbolivia/utils/printUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devfestbolivia/firebase/auth/emailAuth/email_auth.dart';
import 'package:devfestbolivia/firebase/auth/emailAuth/email_auth_repository.dart';

class EmailAuthRepoitoryImpl extends EmailAuthRepository {
  EmailAuth emailAuth = EmailAuth();

  @override
  Future<String> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignedIn() {
    // TODO: implement isSignedIn
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email,
      String password, Function userNotFound, Function wrongPassword) async {
    UserCredential? userCredential = await emailAuth.loginWithEmailAndPassword(
        email, password, userNotFound, wrongPassword);
    PrintUtil.debugPrint('userCredential: $userCredential');
    return userCredential;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
