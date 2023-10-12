class ReportSection {
  final String? id;
  final String? title;
  final int? grantedPoints;
  final int? maxPoints;
  final String? status;
  final String? summary;

  const ReportSection({
    this.id,
    this.title,
    this.grantedPoints,
    this.maxPoints,
    this.status,
    this.summary,
  });

  factory ReportSection.fromJson(Map<String, dynamic> json) {
    return ReportSection(
      id: json['id'],
      title: json['title'],
      grantedPoints: json['grantedPoints'],
      maxPoints: json['maxPoints'],
      status: json['status'],
      summary: json['summary'],
    );
  }
}
