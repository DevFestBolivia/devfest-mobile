import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfileByAttendee(Attendees attendee);
  Future<void> createNewFromAttendee(Attendees attendee);
  Future<void> updateProfileData(Profile profile);
  Future<Profile> getProfileById(String id);
}
