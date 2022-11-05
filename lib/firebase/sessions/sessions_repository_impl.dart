import 'package:devfestbolivia/models/session.dart';
import 'package:devfestbolivia/firebase/sessions/sessions_firestore.dart';
import 'package:devfestbolivia/firebase/sessions/sessions_repository.dart';

class SessionsRepositoryImpl implements SessionsRepository {
  final SessionsFirestore sessionsFirestore = SessionsFirestore();

  @override
  Stream<List<Session>> getAllSessions() {
    return sessionsFirestore.getAllSessions();
  }

  @override
  Future<List<Session>> getAllSessionsFuture() {
    return sessionsFirestore.getAllSessionsFuture();
  }

  @override
  Future<Session> getSessionById(String id) {
    return sessionsFirestore.getSessionsById(id);
  }

}