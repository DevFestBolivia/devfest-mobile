import 'package:devfestbolivia/models/session.dart';

class SpeakerUtil {
  static String? getSpeaker(Session session) {
    if (session.speakers!.isNotEmpty) {
      return session.speakers![0];
    } else {
      return null;
    }
  }
}