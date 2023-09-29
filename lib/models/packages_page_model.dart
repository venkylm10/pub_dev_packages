import 'package_model.dart';

class PackagePage {
  final List<Package> packages;
  final String? next;

  PackagePage({
    required this.packages,
    this.next,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packages': packages.map((x) => x.toMap()).toList(),
      'next': next,
    };
  }

  factory PackagePage.fromMap(Map<String, dynamic> map) {
    return PackagePage(
      packages: List<Package>.from((map['packages'] ).map<Package>((x) => Package.fromMap(x as Map<String,dynamic>),),),
      next: map['next'] != null ? map['next'] as String : null,
    );
  }
}
