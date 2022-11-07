import 'package:devfestbolivia/models/attendees.dart';

class Profile {
  Profile({
    required this.uid,
    required this.imageUrl,
    required this.fullName,
    required this.bio,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.twitterUrl,
    required this.score,
    required this.qrDynamicScans,
    required this.friends,
  });

  final String uid;
  final String imageUrl;
  final String fullName;
  final String bio;
  final String facebookUrl;
  final String instagramUrl;
  final String twitterUrl;
  final double score;
  final List<QrDynamicScan> qrDynamicScans;
  final List<Friend> friends;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      uid: json['uid'],
      imageUrl: json['imageUrl'],
      fullName: json['fullName'],
      bio: json['bio'],
      facebookUrl: json['facebookUrl'],
      instagramUrl: json['instagramUrl'],
      twitterUrl: json['twitterUrl'],
      score: json['score'],
      qrDynamicScans: List<QrDynamicScan>.from((json['qrDynamicScans'] ?? [])
          .map((qrDynamicScanJson) =>
              QrDynamicScan.fromJson(qrDynamicScanJson))),
      friends: List<Friend>.from((json['friends'] ?? [])
          .map((friendJson) => Friend.fromJson(friendJson))),
    );
  }

  factory Profile.fromAttendee(Attendees attendee) {
    return Profile(
      uid: attendee.id!,
      imageUrl: '',
      fullName: attendee.fullName!,
      bio: '',
      facebookUrl: '',
      instagramUrl: '',
      twitterUrl: '',
      score: 0.0,
      qrDynamicScans: [],
      friends: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'fullName': fullName,
      'bio': bio,
      'facebookUrl': facebookUrl,
      'instagramUrl': instagramUrl,
      'twitterUrl': twitterUrl,
      'score': score,
      'qrDynamicScans': qrDynamicScans
          .map((qrDynamicScan) => qrDynamicScan.toJson())
          .toList(),
      'friends': friends.map((friend) => friend.toJson()).toList(),
    };
  }
}

class QrDynamicScan {
  QrDynamicScan({
    required this.value,
    required this.score,
  });

  final String value;
  final double score;

  factory QrDynamicScan.fromJson(Map<String, dynamic> json) {
    return QrDynamicScan(
      value: json['value'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'score': score,
    };
  }
}

class Friend {
  Friend({
    required this.uid,
    required this.fullName,
    required this.imageUrl,
  });

  final String uid;
  final String fullName;
  final String imageUrl;

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      uid: json['uid'] ?? '',
      fullName: json['fullName'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'imageUrl': imageUrl,
    };
  }
}
