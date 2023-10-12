import 'latest_version.dart';
import 'version.dart';

class Package {
  final String name;
  final LatestVersion latest;
  final List<Version>? versions;

  Package({
    required this.name,
    required this.latest,
    this.versions,
  });

  factory Package.fromJson(Map<String, dynamic> json) {
    final versionJson = json['versions'] as List<dynamic>?;
    return Package(
      name: json['name'] as String,
      latest: LatestVersion.fromJson(json['latest']),
      versions: versionJson?.map((version) => Version.fromJson(json)).toList(),
    );
  }
}
