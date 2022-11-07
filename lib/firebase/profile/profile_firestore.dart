import 'package:devfestbolivia/firebase/cloud_firestore.dart';
import 'package:devfestbolivia/firebase/collection_name.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/profile.dart';

class ProfileFirestore extends CloudFireStore {
  Future<Profile?> getProfileByUid(String uid) async {
    try {
      final querySnapshot = await db
          .collection(CollectionName.PROFILES)
          .where('uid', isEqualTo: uid)
          .get();

      final profiles = querySnapshot.docs
          .map(
            (doc) => Profile.fromSnapshot(doc),
          )
          .toList();

      if (profiles.isEmpty) {
        return null;
      }
      return profiles.first;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createFromAttendee(Attendees attendee) async {
    try {
      final newProfile = Profile.fromAttendee(attendee);
      await db.collection(CollectionName.PROFILES).add(newProfile.toJson());
      return;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile(Profile profile) async {
    try {
      await profile.reference?.update(profile.toJson());
    } catch (e) {
      rethrow;
    }
  }
}
