import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfestbolivia/api/collection_name.dart';
import 'package:devfestbolivia/api/cloud_firestore.dart';
import 'package:devfestbolivia/models/Speaker.dart';

class SpeakersFirestore extends CloudFireStore {
  Stream<List<Speaker>> getAllSpeakers() {
    return db.collection(CollectionName.SPEAKERS).snapshots().map(
        (list) => list.docs.map((doc) => Speaker.fromFirestore(doc.id, doc.data())).toList());
  }
}
