import '../../models/speaker.dart';

abstract class SpeakersRepository {
  Stream<List<Speaker>> getAllSpeakers();
  Future<Speaker> getSpeakerById(String id);
}
