class QueryPackage {
  final String package;
  const QueryPackage({required this.package});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'package': package,
    };
  }

  factory QueryPackage.fromMap(Map<String, dynamic> map) {
    return QueryPackage(
      package: map['package'] as String,
    );
  }
}
