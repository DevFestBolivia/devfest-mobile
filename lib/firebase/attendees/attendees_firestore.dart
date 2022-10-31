import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/firebase/collection_name.dart';
import 'package:devfestbolivia/models/attendees.dart';

class AttendeesFirestore extends CloudFireStore {
  Future<Attendees> getAttendeesById(String userId) {
    return db.collection(CollectionName.ATTENDEES).doc(userId).get().then((value) {
      return Attendees.fromFirestore(value.id, value.data());
    });
  }
}
