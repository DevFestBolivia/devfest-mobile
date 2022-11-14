import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/firebase/collection_name.dart';
import 'package:devfestbolivia/models/attendees.dart';

class AttendeesFirestore extends CloudFireStore {
  Future<Attendees> getAttendeesById(String userId) {
    return db
        .collection(CollectionName.ATTENDEES)
        .doc(userId)
        .get()
        .then((value) {
      return Attendees.fromFirestore(value.id, value.data());
    });
  }

  Future<Attendees> getAttendeeByEmail(String email) async {
    try {
      final querySnapshot = await db
          .collection(CollectionName.ATTENDEES)
          .where('email', isEqualTo: email)
          .get();

      final documentSnapshots = querySnapshot.docs;

      if (documentSnapshots.isEmpty) {
        throw Exception('No found user');
      }

      final foundAttendeeDocument = documentSnapshots.first;

      return Attendees.fromFirestore(
          foundAttendeeDocument.id, foundAttendeeDocument.data());
    } catch (e) {
      rethrow;
    }
  }
}
