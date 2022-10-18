import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfestbolivia/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseMain {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}