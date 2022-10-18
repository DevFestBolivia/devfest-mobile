class Speakers {
  String id;
  String bio;
  String company;
  String companyLogo;
  String companyLogoUrl;
  String country;
  bool featured;
  String name;
  int order;
  String photoUrl;
  String pronouns;
  String shortBio;
  List<String> socials = [];
  String title;

  Speakers(
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

  factory Speakers.fromFirestore(Map<String, Object?> json) {
    return Speakers(
        json['id']! as String,
        json['bio']! as String,
        json['company']! as String,
        json['companyLogo']! as String,
        json['companyLogoUrl']! as String,
        json['country']! as String,
        json['featured']! as bool,
        json['name']! as String,
        json['order']! as int,
        json['photoUrl']! as String,
        json['pronouns']! as String,
        json['shortBio']! as String,
        (json['socials']! as List).cast<String>(),
        json['title']! as String);
  }
}
