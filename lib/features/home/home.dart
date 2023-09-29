import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/features/search/search_screen.dart';

class HomeScreen extends ConsumerWidget {
  static String id = "/home";
  const HomeScreen({super.key});

  void navigateToSearchScreen(BuildContext context) {
    Navigator.pushNamed(context, SearchScreen.id);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Pub Packages"),
        backgroundColor: AppStyles.primaryColor,
        actions: [
          IconButton(
            onPressed: () => navigateToSearchScreen(context),
            icon: const Icon(Icons.search_rounded),
          ),
        ],
      ),
      body: Container(
        color: AppStyles.backgroundColor,
      ),
    );
  }
}
