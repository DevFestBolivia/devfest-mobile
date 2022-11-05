import 'package:devfestbolivia/firebase/speakers/speakers_firestore.dart';
import 'package:devfestbolivia/models/speaker.dart';
import 'speakers_repository.dart';

class SpeakersRepositoryImpl extends SpeakersRepository {
  SpeakersFirestore speakersFirestore = SpeakersFirestore();

  @override
  Stream<List<Speaker>> getAllSpeakers() {
    return speakersFirestore.getAllSpeakers();
  }

  @override
  Future<Speaker> getSpeakerById(String id) {
    return speakersFirestore.getSpeakerById(id);
  }
}