import 'package:devfestbolivia/models/social_user.dart';
import 'package:devfestbolivia/firebase/functions/fb_functions.dart';
import 'package:devfestbolivia/firebase/auth/socialAuth/social_auth.dart';
import 'package:devfestbolivia/firebase/functions/functions_repository.dart';
import 'package:devfestbolivia/utils/printUtil.dart';

class FunctionsRepositoryImpl extends FunctionsRepository {
  SocialAuth socialAuth = SocialAuth();
  FbFunctions fbFunctions = FbFunctions();

  @override
  Future<SocialUser> loginWithGoogle() async {
    SocialUser? result = await socialAuth.loginWithGoogle();
    PrintUtil.debugPrint('result: $result');
    PrintUtil.debugPrint('id: ${result.email}');
    PrintUtil.debugPrint('success: ${result.success}');
    PrintUtil.debugPrint('serverAuthCode: ${result.serverAuthCode}');
    PrintUtil.debugPrint('displayName: ${result.displayName}');
    PrintUtil.debugPrint('photoUrl: ${result.photoUrl}');
    return result;
  }
}
