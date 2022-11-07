import 'dart:convert';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

Schedule scheduleFromFirestore(String id, Map<String, dynamic> data) {
  Schedule schedule = Schedule.fromJson(data);
  return schedule;
}

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule {
  Schedule({
    required this.date,
    required this.dateReadable,
    required this.timeslots,
    required this.tracks,
    required this.description,
  });

  DateTime date;
  String dateReadable;
  List<Timeslot> timeslots;
  List<Track> tracks;
  String description;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        date: DateTime.parse(json["date"]),
        dateReadable: json["dateReadable"],
        timeslots: List<Timeslot>.from(
          json["timeslots"].map((x) => Timeslot.fromJson(x)),
        ),
        tracks: List<Track>.from(
          json["tracks"].map((x) => Track.fromJson(x)),
        ),
        description: json['description'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "dateReadable": dateReadable,
        "timeslots": List<dynamic>.from(timeslots.map((x) => x.toJson())),
        "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
        'description': description,
      };
}

class Timeslot {
  Timeslot({
    required this.sessions,
    required this.startTime,
    required this.endTime,
  });

  List<Session> sessions;
  String startTime;
  String endTime;

  factory Timeslot.fromJson(Map<String, dynamic> json) => Timeslot(
        sessions: List<Session>.from(
            json["sessions"].map((x) => Session.fromJson(x))),
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
        "startTime": startTime,
        "endTime": endTime,
      };
}

class Session {
  Session({
    required this.items,
    required this.extend,
  });

  List<String> items;
  int? extend;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        items: List<String>.from(json["items"].map((x) => x)),
        extend: json["extend"] == null ? null : json["extend"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x)),
        "extend": extend == null ? null : extend,
      };
}

class Track {
  Track({
    required this.title,
    required this.speaker,
    required this.speakerImage,
  });

  String title;
  String speaker;
  String speakerImage;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        title: json["title"],
        speaker: json["speaker"] ?? '',
        speakerImage: json["speakerImage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "speaker": speaker,
        "speakerImage": speakerImage,
      };
}
