class Version {
  final String version;
  const Version({required this.version});

  factory Version.fromJson(Map<String, dynamic> json) {
    return Version(
      version: json['version'] as String,
    );
  }
}

