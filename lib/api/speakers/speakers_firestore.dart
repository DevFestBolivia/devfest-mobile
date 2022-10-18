import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devfestbolivia/api/CollectionName.dart';
import 'package:devfestbolivia/api/cloud_firestore.dart';
import 'package:devfestbolivia/models/Speakers.dart';

class SpeakersFirestore extends CloudFireStore {
  Stream<List<Speakers>> getAllSpeakers() {
    return db.collection(CollectionName.SPEAKERS).snapshots().map(
        (list) => list.docs.map((doc) => Speakers.fromFirestore(doc.data())).toList());
  }
}
