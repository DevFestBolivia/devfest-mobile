import 'package:devfestbolivia/models/session.dart';

abstract class SessionsRepository {
  Stream<List<Session>> getAllSessions();
  Future<List<Session>> getAllSessionsFuture();
  Future<Session> getSessionById(String id);
}