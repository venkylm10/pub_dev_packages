import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/pages/search/search_screen.dart';
import 'package:pub_dev_packages/models/package_model/package_model.dart';
import 'package:pub_dev_packages/services/api.dart';
import 'package:pub_dev_packages/utils/scroll_up_botton.dart';
import 'package:pub_dev_packages/utils/skeleton.dart';
import 'package:pub_dev_packages/widgets/home/home_package_tile.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String id = "/home";
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final scrollController = ScrollController();
  var favouritePackages = <Package>[];
  bool isLoading = true;
  bool _isVisible = false;

  @override
  void initState() {
    getFavourites();
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset >= 300) {
        _isVisible = true;
      } else {
        _isVisible = false;
      }
      setState(() {});
    });
  }

  void navigateToSearchScreen(BuildContext context) {
    Navigator.push(
      context,
      PageTransition(
        duration: const Duration(milliseconds: 500),
        type: PageTransitionType.rightToLeftWithFade,
        curve: Curves.decelerate,
        child: const SearchScreen(),
      ),
    );
  }

  void getFavourites() async {
    try {
      setState(() {
        isLoading = true;
      });
      favouritePackages = await ref.read(apiServicesProvider).getFavourites();
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
      top: false,
      child: Scaffold(
        backgroundColor: AppStyles.backgroundColor,
        appBar: AppBar(
          title: Text(
            "Pub Packages",
            style: AppStyles.headingStyle,
          ),
          backgroundColor: AppStyles.primaryColor,
          actions: [
            IconButton(
              onPressed: () => navigateToSearchScreen(context),
              icon: const Icon(
                Icons.search_rounded,
                color: AppStyles.blue1,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12).copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Some Flutter favorites",
                    style: AppStyles.subHeadingStyle,
                  ),
                  Text(
                    "know more",
                    style: AppStyles.normalTextStyle.copyWith(
                      color: AppStyles.blue1,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              isLoading ? _buildPackageListShimmer() : _buildPopularPackages(),
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
        baseColor: AppStyles.secondaryColor,
        highlightColor: AppStyles.whiteColor.withOpacity(0.2),
        direction: ShimmerDirection.ttb,
        child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return const Skeleton(
              height: 45,
              width: double.infinity,
            );
          },
        ),
      ),
    );
  }

  Widget _buildPopularPackages() {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: favouritePackages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return HomePackageTile(package: favouritePackages[index]);
        },
      ),
    );
  }
}
