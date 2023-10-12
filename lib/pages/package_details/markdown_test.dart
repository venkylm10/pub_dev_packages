import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkDownWidget extends StatelessWidget {
  const MarkDownWidget({super.key});
  final markDownText =
      """### [*] 10/10 points: Provide a valid `pubspec.yaml`\n\n\n### [*] 5/5 points: Provide a valid `README.md`\n\n\n### [*] 5/5 points: Provide a valid `CHANGELOG.md`\n\n\n### [*] 10/10 points: Use an OSI-approved license\n\nDetected license: `MIT`.""";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Markdown(data: markDownText),
      ),
    );
  }
}
