class Result {
  final String? homepageUrl;
  final String? repositoryUrl;
  final String? issueTrackerUrl;

  const Result({
    this.homepageUrl,
    this.repositoryUrl,
    this.issueTrackerUrl,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      homepageUrl: json['homepageUrl'],
      repositoryUrl: json['repositoryUrl'],
      issueTrackerUrl: json['issueTrackerUrl'],
    );
  }
}
