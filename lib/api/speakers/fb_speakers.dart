import 'package:devfestbolivia/api/speakers/speakers_firestore.dart';
import 'package:devfestbolivia/models/Speakers.dart';
import 'speakers_repository.dart';

class SpeakersRepositoryImpl extends SpeakersRepository {
  SpeakersFirestore speakersFirestore = SpeakersFirestore();

  @override
  Stream<List<Speakers>> getAllSpeakers() {
    return speakersFirestore.getAllSpeakers();
  }
}