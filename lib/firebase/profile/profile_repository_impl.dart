import 'package:devfestbolivia/firebase/profile/profile_firestore.dart';
import 'package:devfestbolivia/firebase/profile/profile_repository.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/social_user.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({
    required ProfileFirestore profileFirestore,
  }) : _profileFirestore = profileFirestore;

  final ProfileFirestore _profileFirestore;

  @override
  Future<void> createNewFromAttendee(
      Attendees attendee, SocialUser? socialUser) async {
    await _profileFirestore.createFromAttendee(
      attendee,
      socialUser,
    );
  }

  @override
  Future<Profile> getProfileByAttendee(
      Attendees attendee, SocialUser? socialUser) async {
    try {
      final profile = await _profileFirestore.getProfileByUid(attendee.id!);
      if (profile == null) {
        await createNewFromAttendee(attendee, socialUser);
        return getProfileByAttendee(attendee, socialUser);
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
