import 'dependency.dart';
import 'environment.dart';

class Pubspec {
  Pubspec({
    required this.name,
    required this.description,
    required this.version,
    this.homepage,
    this.repository,
    this.environment,
    this.dependencies,
    this.devDependencies,
  });
  final String name;
  final String description;
  final String version;
  final String? homepage;
  final String? repository;
  final Environment? environment;
  final List<Dependency>? dependencies;
  final List<Dependency>? devDependencies;

  factory Pubspec.fromJson(Map<String, dynamic> json) {
    final dependenciesJson = json['dependencies'];
    final devDependeciesJson = json['dev_dependencies'];

    return Pubspec(
      name: json['name'] as String,
      description: json['description'] as String,
      version: json['version'] as String,
      homepage: json['homepage'],
      repository: json['repository'],
      environment: Environment.fromJson(json['environment']),
      dependencies: _convertToDependencyList(dependenciesJson),
      devDependencies: _convertToDependencyList(devDependeciesJson),
    );
  }
}

List<Dependency>? _convertToDependencyList(Map<String, dynamic>? json) {
  if (json == null) {
    return null;
  }

  return json.entries.map((entry) {
    if (entry.value is Map<String, dynamic>) {
      return Dependency(
        name: entry.key,
        version:
            "${entry.key} : ${entry.value[(entry.value as Map<String, dynamic>).keys.first]}",
      );
    } else {
      return Dependency(
        name: entry.key,
        version: entry.value,
      );
    }
  }).toList(growable: false);
}
