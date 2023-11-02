class Score {
  final int? grantedPoints;
  final int? maxPoints;
  final int? likeCount;
  final double? popularityScore;
  final String? lastUpdated;
  final List<String>? tags;
  Score({
    this.grantedPoints,
    this.maxPoints,
    this.likeCount,
    this.popularityScore,
    this.lastUpdated,
    this.tags,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      grantedPoints: json['grantedPoints'],
      maxPoints: json['maxPoints'],
      likeCount: json['likeCount'],
      popularityScore: json['popularityScore'],
      lastUpdated: json['lastUpdated'],
      tags: (json['tags'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }
}

Map<String, dynamic> dummyScore = {
  "grantedPoints": 0,
  "maxPoints": 140,
  "likeCount": 0,
  "popularityScore": 0.0,
  "lastUpdated": DateTime.utc(2023, 1, 1, 0, 0, 0).toString(),
  "tags": [],
};

bool supportsAndroid(List<String> tags) {
  if (tags.contains('platform:android')) {
    return true;
  }
  return false;
}

bool supportsIos(List<String> tags) {
  if (tags.contains('platform:ios')) {
    return true;
  }
  return false;
}

bool supportsLinux(List<String> tags) {
  if (tags.contains('platform:linux')) {
    return true;
  }
  return false;
}

bool supportsWindows(List<String> tags) {
  if (tags.contains('platform:windows')) {
    return true;
  }
  return false;
}

bool supportsMacos(List<String> tags) {
  if (tags.contains('platform:macos')) {
    return true;
  }
  return false;
}

bool supportsWeb(List<String> tags) {
  if (tags.contains('platform:web')) {
    return true;
  }
  return false;
}

bool isNullSafe(List<String> tags) {
  if (tags.contains("is:null-safe")) {
    return true;
  }
  return false;
}

bool isDart3Compatible(List<String> tags) {
  if (tags.contains("is:dart3-compatible")) {
    return true;
  }
  return false;
}
