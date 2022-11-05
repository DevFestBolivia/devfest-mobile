import 'package:devfestbolivia/models/session.dart';
import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/firebase/collection_name.dart';

class SessionsFirestore extends CloudFireStore {
  Stream<List<Session>> getAllSessions() {
    return db.collection(CollectionName.SESSIONS).snapshots().map((list) => list
        .docs
        .map((doc) => Session.fromFirestore(doc.id, doc.data()))
        .toList());
  }

  Future<List<Session>> getAllSessionsFuture() async {
    return await db.collection(CollectionName.SESSIONS).get().then((list) =>
        list.docs
            .map((doc) => Session.fromFirestore(doc.id, doc.data()))
            .toList());
  }

  Future<Session> getSessionsById(String id) async {
    return db.collection(CollectionName.SESSIONS).doc(id).get().then((doc) {
      return Session.fromFirestore(doc.id, doc.data());
    });
  }
}
