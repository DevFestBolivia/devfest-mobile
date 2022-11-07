import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/firebase/collection_name.dart';
import 'package:devfestbolivia/models/schedule.dart';

class SchedulesFirestore extends CloudFireStore {
  Stream<List<Schedule>> getAllSchedules() {
    return db.collection(CollectionName.SCHEDULE).snapshots().map((list) => list
        .docs
        .map((doc) => scheduleFromFirestore(doc.id, doc.data()))
        .toList());
  }

  Future<List<Schedule>> getAllSchedulesFuture() async {
    return await db.collection(CollectionName.SCHEDULE).get().then((list) =>
        list.docs
            .map((doc) => scheduleFromFirestore(doc.id, doc.data()))
            .toList());
  }
}
