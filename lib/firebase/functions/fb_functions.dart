import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/utils/printUtil.dart';

class FbFunctions extends CloudFireStore {
  Future<HttpsCallableResult> loginWithGoogle(
      String id, String email, String displayName, String photoUrl) async {
    PrintUtil.debugPrint('email: $email');

    HttpsCallable callable = functions.httpsCallable(
      'loginWithGoogle',
      options: HttpsCallableOptions(
        timeout: const Duration(seconds: 5),
      ),
    );
    return await callable.call(<String, dynamic>{
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'serverAuthCode': id,
    });
  }
}
