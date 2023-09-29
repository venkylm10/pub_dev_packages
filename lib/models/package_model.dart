class Package {
  final String package;
  const Package({required this.package});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'package': package,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      package: map['package'] as String,
    );
  }
}
