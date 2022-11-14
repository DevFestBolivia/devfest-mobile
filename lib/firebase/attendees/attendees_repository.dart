import 'package:devfestbolivia/models/attendees.dart';

abstract class AttendeesRepository {
  Future<Attendees> getAttendeesById(String userId);
  Future<Attendees> getAttendeesByEmail(String email);
}
