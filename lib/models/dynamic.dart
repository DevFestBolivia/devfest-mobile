class DynamicQRResult {
  DynamicQRResult({
    required this.value,
    required this.score,
    required this.type,
  });

  final String value;
  final double score;
  final String type;

  factory DynamicQRResult.fromJson(Map<String, dynamic> json) {
    return DynamicQRResult(
      value: json['value'] ?? '',
      score: json['score'] ?? 0.0,
      type: json['type'] ?? '',
    );
  }
}
