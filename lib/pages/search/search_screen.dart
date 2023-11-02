import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/constants/colors.dart';
import 'package:pub_dev_packages/constants/styles.dart';
import 'package:pub_dev_packages/pages/search/search_controller.dart';
import 'package:pub_dev_packages/utils/loader.dart';
import 'package:pub_dev_packages/utils/search_package_tile.dart';
import 'package:pub_dev_packages/utils/scroll_up_botton.dart';
import 'package:pub_dev_packages/utils/skeleton.dart';
import 'package:shimmer/shimmer.dart';
import '../../models/package_model/query_package_model.dart';

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
  List<QueryPackage> packages = [];
  bool _isVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    packageNameController = TextEditingController();
    ref.read(searchControllerProvider.notifier).nextPageAvailable = true;
    if (pageNumber == 0 && packageNameController.text == '') {
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
      var nextTenPackages = <QueryPackage>[];
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
        isLoading = false;
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor,
        body: Container(
          color: AppColors.backgroundColor,
          padding: const EdgeInsets.all(15).copyWith(bottom: 0, top: 10),
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
                      borderSide:
                          const BorderSide(color: AppColors.secondaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColors.secondaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: AppColors.secondaryColor)),
                ),
                onSubmitted: (value) {
                  _resetParameters();
                  _fetchData(packageNameController.text);
                  _scrollToTop();
                },
              ),
              const SizedBox(height: 20),
              isLoading ? _buildPackageListShimmer() : _buildSearchResults(ref),
            ],
          ),
        ),
        floatingActionButton: _isVisible
            ? ScrollUpButton(scrollToTop: _scrollToTop)
            : const SizedBox(),
      ),
    );
  }

  Widget _buildPackageListShimmer() {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: AppColors.secondaryColor,
        highlightColor: AppColors.whiteColor.withOpacity(0.2),
        direction: ShimmerDirection.ttb,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return const Skeleton(
              height: 60,
              width: double.infinity,
              borderRadius: 20,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults(WidgetRef ref) {
    final nextPageAvailable =
        ref.watch(searchControllerProvider.notifier).nextPageAvailable;
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: packages.length + 1,
        itemBuilder: (context, index) {
          if (index == packages.length) {
            return Center(
              child: nextPageAvailable
                  ? const Loader()
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "No more data found",
                        style: AppStyles.normalTextStyle,
                      ),
                    ),
            );
          }
          return SearchPackageTile(
            packageName: packages[index].package,
          );
        },
      ),
    );
  }
}
