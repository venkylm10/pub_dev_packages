class Environment {
  Environment({
    required this.sdk,
    required this.flutter,
  });
  final String? sdk;
  final String? flutter;

  factory Environment.fromJson(Map<String, dynamic> json) {
    return Environment(
      sdk: json['sdk'],
      flutter: json['flutter'],
    );
  }
}
