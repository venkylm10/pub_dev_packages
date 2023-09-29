import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/features/search/search_controller.dart';
import 'package:pub_dev_packages/utils/loader.dart';
import 'package:pub_dev_packages/utils/package_tile.dart';

import '../../models/package_model.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String id = '/home/login';
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late TextEditingController packageNameController;
  final scrollController = ScrollController();
  int pageNumber = 0;
  List<Package> packages = [];
  bool _isVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    packageNameController = TextEditingController();
    ref.read(searchControllerProvider.notifier).nextPageAvailable = true;
    if (pageNumber == 0 && packageNameController.text == '') {
      _fetchData(packageNameController.text);
      _fetchData(packageNameController.text);
      _fetchData(packageNameController.text);
    }
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
              scrollController.offset &&
          ref.read(searchControllerProvider.notifier).nextPageAvailable) {
        _fetchData(packageNameController.text);
      }
      if (scrollController.offset >= 300) {
        _isVisible = true;
      } else {
        _isVisible = false;
      }
      setState(() {});
    });
  }

  void _resetParameters() {
    isLoading = false;
    packages = [];
    pageNumber = 0;
  }

  void _fetchData(String packageName) async {
    try {
      if (pageNumber == 0) {
        setState(() {
          isLoading = true;
        });
      }
      var nextTenPackages = <Package>[];
      nextTenPackages = await ref
          .read(searchControllerProvider.notifier)
          .getPage(packageName, ++pageNumber);
      packages.addAll(nextTenPackages);

      if (ref.read(searchControllerProvider.notifier).nextPageAvailable) {
        nextTenPackages = await ref
            .read(searchControllerProvider.notifier)
            .getPage(packageName, ++pageNumber);
        packages.addAll(nextTenPackages);
      }
      setState(() {
        if ([0, 1, 2, 3, 4, 5, 6, 7, 8].contains(pageNumber)) {
          isLoading = false;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nextPageAvailable =
        ref.watch(searchControllerProvider.notifier).nextPageAvailable;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          color: AppStyles.backgroundColor,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 5),
              TextField(
                controller: packageNameController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Enter package name",
                  prefixIcon: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => packageNameController.text = '',
                    icon: const Icon(Icons.cancel_outlined),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.white)),
                ),
                onSubmitted: (value) {
                  _resetParameters();
                  _fetchData(packageNameController.text);
                  _scrollToTop();
                },
              ),
              const SizedBox(height: 20),
              isLoading
                  ? const Expanded(child: Loader())
                  : Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: packages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == packages.length) {
                            return Center(
                              child: nextPageAvailable
                                  ? const Loader()
                                  : const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("No more data found"),
                                    ),
                            );
                          }
                          return PackageTile(
                              packageName: packages[index].package);
                        },
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: _isVisible
            ? ElevatedButton(
                onPressed: _scrollToTop,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppStyles.secondaryColor,
                  shape: const CircleBorder(
                      side: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  )),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Transform.rotate(
                    angle: pi / 2,
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
