class Speaker {
  String id;
  String? bio;
  String? company;
  String? companyLogo;
  String? companyLogoUrl;
  String? country;
  bool? featured;
  String? name;
  int? order;
  String? photoUrl;
  String? pronouns;
  String? shortBio;
  List<String>? socials = [];
  String? title;

  Speaker(
      this.id,
      this.bio,
      this.company,
      this.companyLogo,
      this.companyLogoUrl,
      this.country,
      this.featured,
      this.name,
      this.order,
      this.photoUrl,
      this.pronouns,
      this.shortBio,
      this.socials,
      this.title);

  factory Speaker.fromFirestore(String id, Map<String, dynamic>? json) {
    Speaker newSpeaker = Speaker(
        id,
        json != null && json['bio'] != null ? json['bio'] as String : null,
        json != null &&  json['company'] != null ? json['company'] as String : null,
        json != null &&  json['companyLogo'] != null ? json['companyLogo']! as String : null,
        json != null &&  json['companyLogoUrl'] != null
            ? json['companyLogoUrl']! as String
            : null,
        json != null && json['country'] != null ? json['country']! as String : null,
        json != null && json['featured'] != null ? json['featured']! as bool : null,
        json != null && json['name'] != null ? json['name']! as String : null,
        json != null && json['order'] != null ? json['order']! as int : null,
        json != null && json['photoUrl'] != null ? json['photoUrl']! as String : null,
        json != null && json['pronouns'] != null ? json['pronouns']! as String : null,
        json != null && json['shortBio'] != null ? json['shortBio']! as String : null,
        json != null && json['socials'] != null
            ? (json['socials']! as List).cast<String>()
            : [],
        json != null && json['title'] != null ? json['title']! as String : null);
    return newSpeaker;
  }
}
