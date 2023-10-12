import 'query_package_model.dart';

class QueryPackageList {
  final List<QueryPackage> packages;
  final String? next;

  QueryPackageList({
    required this.packages,
    this.next,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packages': packages.map((x) => x.toMap()).toList(),
      'next': next,
    };
  }

  factory QueryPackageList.fromMap(Map<String, dynamic> map) {
    return QueryPackageList(
      packages: List<QueryPackage>.from(
        (map['packages']).map<QueryPackage>(
          (x) => QueryPackage.fromMap(x as Map<String, dynamic>),
        ),
      ),
      next: map['next'] != null ? map['next'] as String : null,
    );
  }

  QueryPackageList copyWith({
    List<QueryPackage>? packages,
    String? next,
  }) {
    return QueryPackageList(
      packages: packages ?? this.packages,
      next: next ?? this.next,
    );
  }
}
