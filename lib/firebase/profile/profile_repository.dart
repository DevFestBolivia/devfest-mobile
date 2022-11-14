import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/profile.dart';
import 'package:devfestbolivia/models/social_user.dart';

abstract class ProfileRepository {
  Future<Profile> getProfileByAttendee(
    Attendees attendee,
    SocialUser? socialUser,
  );
  Future<void> createNewFromAttendee(
    Attendees attendee,
    SocialUser? socialUser,
  );
  Future<void> updateProfileData(Profile profile);
  Future<Profile> getProfileById(String id);
}
