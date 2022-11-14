import 'package:cloud_functions/cloud_functions.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/social_user.dart';
import 'package:devfestbolivia/firebase/functions/fb_functions.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth.dart';
import 'package:devfestbolivia/firebase/functions/functions_repository.dart';

class FunctionsRepositoryImpl extends FunctionsRepository {
  SocialAuth socialAuth = SocialAuth();
  FbFunctions fbFunctions = FbFunctions();

  @override
  Future<SocialUser> loginWithGoogle() async {
    SocialUser? result = await socialAuth.loginWithGoogle();
    print('result: $result');
    print('id: ${result.email}');
    print('success: ${result.success}');
    print('serverAuthCode: ${result.serverAuthCode}');
    print('displayName: ${result.displayName}');
    print('photoUrl: ${result.photoUrl}');
    // if (result.success) {
    //   HttpsCallableResult document = await fbFunctions.loginWithGoogle(
    //     result.serverAuthCode!,
    //     result.email!,
    //     result.displayName!,
    //     result.photoUrl!,
    //   );
    //   print('document: ${document.data}');

    //   Attendees attendees = Attendees.fromJson(document.data);
    //   print('attendees: ${attendees.fullName}');
    // }
    return result;
  }
}
