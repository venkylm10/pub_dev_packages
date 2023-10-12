import 'pubspec.dart';

class LatestVersion {
  LatestVersion({
    required this.version,
    required this.pubspec,
  });
  final String version;
  final Pubspec pubspec;

  factory LatestVersion.fromJson(Map<String, dynamic> map) {
    return LatestVersion(
      version: map['version'] as String,
      pubspec: Pubspec.fromJson(map['pubspec'] as Map<String, dynamic>),
    );
  }
}
