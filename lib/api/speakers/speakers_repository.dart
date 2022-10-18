

import '../../models/Speakers.dart';

abstract class SpeakersRepository {
  Stream<List<Speakers>> getAllSpeakers();
}
