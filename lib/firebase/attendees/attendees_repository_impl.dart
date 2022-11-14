import 'package:devfestbolivia/models/attendees.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_firestore.dart';
import 'package:devfestbolivia/firebase/attendees/attendees_repository.dart';

class AttendeesRepositoryImpl implements AttendeesRepository {
  final AttendeesFirestore _attendeesFirestore = AttendeesFirestore();

  @override
  Future<Attendees> getAttendeesById(String userId) {
    return _attendeesFirestore.getAttendeesById(userId);
  }

  @override
  Future<Attendees> getAttendeesByEmail(String email) async {
    return await _attendeesFirestore.getAttendeeByEmail(email);
  }
}
