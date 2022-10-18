import '../../models/Speaker.dart';

abstract class SpeakersRepository {
  Stream<List<Speaker>> getAllSpeakers();
}
