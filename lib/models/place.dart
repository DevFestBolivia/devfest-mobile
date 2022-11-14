class Place {
  Place({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
    );
  }
}
