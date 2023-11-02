import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pub_dev_packages/constants/colors.dart';
import 'package:pub_dev_packages/constants/styles.dart';
import 'package:pub_dev_packages/constants/assets.dart';
import 'package:pub_dev_packages/models/package_model/matrics/score.dart';
import 'package:pub_dev_packages/pages/home/favourites_controller.dart';
import 'package:pub_dev_packages/pages/search/search_screen.dart';
import 'package:pub_dev_packages/models/package_model/package_model.dart';
import 'package:pub_dev_packages/services/api.dart';
import 'package:pub_dev_packages/utils/scroll_up_botton.dart';
import 'package:pub_dev_packages/utils/skeleton.dart';
import 'package:pub_dev_packages/widgets/home/favorites_info_sheet.dart';
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
  var favScores = <Score>[];
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
      await ref.read(favPackagesProvider).getFavorites();
      ref.read(favPackagesProvider).getScores();
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
    favouritePackages = ref.watch(favPackagesProvider).favoritePackages;
    favScores = ref.watch(favPackagesProvider).favScores;
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: Text(
            "Pub Packages",
            style: AppStyles.headingStyle,
          ),
          backgroundColor: AppColors.primaryColor,
          actions: [
            IconButton(
              onPressed: () => navigateToSearchScreen(context),
              icon: const Icon(
                Icons.search_rounded,
                color: AppColors.blue1,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12).copyWith(bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Some Flutter favorites ",
                    style: AppStyles.subHeadingStyle,
                  ),
                  GestureDetector(
                    onTap: showFavoritesInfo,
                    child: IconButton(
                      onPressed: () => showFavoritesInfo(),
                      constraints: const BoxConstraints(maxHeight: 30),
                      padding: const EdgeInsets.only(right: 10),
                      icon: SvgPicture.asset(
                        Assets.icons.infoSvg,
                        height: 18,
                        colorFilter: const ColorFilter.mode(
                          AppColors.blue1,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              isLoading ? _buildPackageListShimmer() : _buildFavorites(),
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
              height: 120,
              width: double.infinity,
            );
          },
        ),
      ),
    );
  }

  void showFavoritesInfo() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isDismissible: true,
      showDragHandle: false,
      enableDrag: true,
      builder: (context) {
        return const ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          child: FavoritesInfo(),
        );
      },
    );
  }

  Widget _buildFavorites() {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: favouritePackages.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return HomePackageTile(packageIndex: index);
        },
      ),
    );
  }
}
