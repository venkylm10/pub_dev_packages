class FlutterVersions {
  final String? frameworkVersion;
  final String? dartSdkVersion;
  final String? devToolsVersion;
  final String? flutterVersion;

  FlutterVersions({
    this.frameworkVersion,
    this.dartSdkVersion,
    this.devToolsVersion,
    this.flutterVersion,
  });

  factory FlutterVersions.fromJson(Map<String, dynamic> json) {
    return FlutterVersions(
      frameworkVersion: json['frameworkVersion'],
      dartSdkVersion: json['dartSdkVersion'],
      devToolsVersion: json['devToolsVersion'],
      flutterVersion: json['flutterVersion'],
    );
  }
}
