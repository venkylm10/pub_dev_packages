import 'package_model.dart';

class PackageList {
  final List<Package> packages;
  final String? next;

  PackageList({
    required this.packages,
    this.next,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packages': packages.map((x) => x.toMap()).toList(),
      'next': next,
    };
  }

  factory PackageList.fromMap(Map<String, dynamic> map) {
    return PackageList(
      packages: List<Package>.from(
        (map['packages']).map<Package>(
          (x) => Package.fromMap(x as Map<String, dynamic>),
        ),
      ),
      next: map['next'] != null ? map['next'] as String : null,
    );
  }
}
