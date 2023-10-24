class Score {
  final int? grantedPoints;
  final int? maxPoints;
  final int? likeCount;
  final double? popularityScore;
  final String? lastUpdated;
  Score({
    this.grantedPoints,
    this.maxPoints,
    this.likeCount,
    this.popularityScore,
    this.lastUpdated,
  });

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      grantedPoints: json['grantedPoints'],
      maxPoints: json['maxPoints'],
      likeCount: json['likeCount'],
      popularityScore: json['popularityScore'],
      lastUpdated: json['lastUpdated'],
    );
  }
}

final dummyScore = {
  "grantedPoints": 0,
  "maxPoints": 0,
  "likeCount": 0,
  "popularityScore": 0.0,
  "lastUpdated": "2023-10-18T18:16:15.028359"
};
