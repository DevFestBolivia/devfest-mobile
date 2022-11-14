class Session {
  String? id;
  String? complexity;
  String? description;
  String? language;
  String? presentation;
  List<String>? speakers;
  List<String>? tags;
  String? title;

  Session(
    this.id,
    this.complexity,
    this.description,
    this.language,
    this.presentation,
    this.speakers,
    this.tags,
    this.title,
  );

  factory Session.fromFirestore(String id, Map<String, dynamic>? json) {
    // print('json $json');
    Session newSession = Session(
      id,
      json != null && json['complexity'] != null ? json['complexity'] as String : null,
      json != null && json['description'] != null ? json['description'] as String : null,
      json != null && json['language'] != null ? json['language'] as String : null,
      json != null && json['presentation'] != null ? json['presentation'] as String : null,
      json != null && json['speakers'] != null ? (json['speakers'] as List).cast<String>() : [],
      json != null && json['tags'] != null ? (json['tags'] as List).cast<String>() : [],
      json != null && json['title'] != null ? json['title'] as String : null,
    );
    // print('id: $id');
    // print('speakers ${newSession.speakers}');
    // print('tags ${newSession.tags}');
    return newSession;
  }
}
