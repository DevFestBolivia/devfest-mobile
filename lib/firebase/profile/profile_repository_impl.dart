import 'package:devfestbolivia/firebase/profile/profile_firestore.dart';
import 'package:devfestbolivia/firebase/profile/profile_repository.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/models/attendees.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileFirestore profileFirestore,
  }) : _profileFirestore = profileFirestore;

  final ProfileFirestore _profileFirestore;

  @override
  Future<void> createNewFromAttendee(Attendees attendee) async {
    await _profileFirestore.createFromAttendee(attendee);
  }

  @override
  Future<Profile> getProfileByAttendee(Attendees attendee) async {
    try {
      final profile = await _profileFirestore.getProfileByUid(attendee.id!);
      if (profile == null) {
        await createNewFromAttendee(attendee);
        return getProfileByAttendee(attendee);
      }
      return profile;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProfileData(Profile profile) async {
    try {
      await _profileFirestore.updateProfile(profile);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Profile> getProfileById(String id) async {
    try {
      final profile = await _profileFirestore.getProfileByUid(id);

      if (profile != null) {
        throw Exception('No profile');
      }

      return profile!;
    } catch (e) {
      rethrow;
    }
  }
}
