class SocialLink {
  final String name;
  final String icon;
  final String link;

  SocialLink({
    required this.name,
    required this.icon,
    required this.link,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        name: json["name"],
        icon: json["icon"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "icon": icon,
        "link": link,
      };
}
