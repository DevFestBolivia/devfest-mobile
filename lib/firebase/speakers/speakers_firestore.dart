import 'package:devfestbolivia/firebase/collection_name.dart';
import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/models/speaker.dart';

class SpeakersFirestore extends CloudFireStore {
  Stream<List<Speaker>> getAllSpeakers() {
    return db.collection(CollectionName.SPEAKERS).snapshots().map(
          (list) => list.docs
              .map((doc) => Speaker.fromFirestore(
                    doc.id,
                    doc.data(),
                  ))
              .toList(),
        );
  }

  Future<Speaker> getSpeakerById(String id) async {
    var doc = await db.collection(CollectionName.SPEAKERS).doc(id).get();
    return Speaker.fromFirestore(doc.id, doc.data());
  }
}
