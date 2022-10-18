import 'package:devfestbolivia/firebase/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMain {
  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}