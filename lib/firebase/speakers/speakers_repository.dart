import '../../models/speaker.dart';

abstract class SpeakersRepository {
  Stream<List<Speaker>> getAllSpeakers();
}
