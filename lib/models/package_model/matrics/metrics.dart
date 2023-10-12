import 'package:pub_dev_packages/models/package_model/matrics/flutter_versions.dart';
import 'package:pub_dev_packages/models/package_model/matrics/report_section.dart';
import 'package:pub_dev_packages/models/package_model/matrics/result.dart';
import 'package:pub_dev_packages/models/package_model/matrics/score.dart';

class Metrics {
  final Score? score;
  final List<String>? tags;
  final String? packageVersion;
  final String? runtimeVersion;
  final String? sdkVersion;
  final FlutterVersions? flutterVersions;
  final Result? result;
  final List<ReportSection>? report;
  Metrics({
    this.score,
    this.tags,
    this.packageVersion,
    this.runtimeVersion,
    this.sdkVersion,
    this.flutterVersions,
    this.result,
    this.report,
  });

  factory Metrics.fromJson(Map<String, dynamic> json) {
    return Metrics(
      score: Score.fromJson(json['score']),
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      packageVersion: json['packageVersion'],
      runtimeVersion: json['runtimeVersion'],
      sdkVersion: json['sdkVersion'],
      flutterVersions: FlutterVersions.fromJson(json['flutterVersions']),
      result: Result.fromJson(json['result']),
      report: json['report'] != null
          ? List<ReportSection>.from(
              (json['report'] as List<dynamic>).map(
                (section) =>
                    ReportSection.fromJson(section as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
