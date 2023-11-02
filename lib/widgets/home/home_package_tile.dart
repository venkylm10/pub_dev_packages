import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pub_dev_packages/constants/assets.dart';
import 'package:pub_dev_packages/constants/colors.dart';
import 'package:pub_dev_packages/constants/styles.dart';
import 'package:pub_dev_packages/globals/dart_logo.dart';
import 'package:pub_dev_packages/models/package_model/matrics/score.dart';
import 'package:pub_dev_packages/pages/home/favourites_controller.dart';

class HomePackageTile extends ConsumerWidget {
  final int packageIndex;
  const HomePackageTile({
    required this.packageIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final package =
        ref.read(favPackagesProvider).favoritePackages[packageIndex];
    final score = ref.watch(favPackagesProvider).favScores[packageIndex];
    final sdkVersion = package.latest.pubspec.environment?.sdk ?? '';
    final flutterVersion = package.latest.pubspec.environment?.flutter ?? '';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
          .copyWith(right: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        border: Border.all(
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          dartLogo,
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppStyles.subHeadingStyle
                      .copyWith(color: AppColors.whiteColor),
                ),
                Text(
                  package.latest.version,
                  style: AppStyles.normalTextStyle.copyWith(
                    color: AppColors.blue1,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  package.latest.pubspec.description,
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.normalTextStyle,
                ),
                const SizedBox(height: 10),
                if (sdkVersion.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "sdk  :  ",
                        style: AppStyles.normalTextStyle,
                      ),
                      Text(
                        sdkVersion,
                        style: AppStyles.normalTextStyle.copyWith(
                          color: AppColors.blue1,
                        ),
                      ),
                    ],
                  ),
                if (flutterVersion.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "flutter  :  ",
                        style: AppStyles.normalTextStyle,
                      ),
                      Text(
                        flutterVersion,
                        style: AppStyles.normalTextStyle.copyWith(
                          color: AppColors.blue1,
                        ),
                      ),
                    ],
                  ),
                Row(
                  children: [
                    buildChip(
                      Assets.icons.likesSvg,
                      (score.likeCount ?? 0).toString(),
                    ),
                    buildChip(
                      Assets.icons.pointsSvg,
                      (score.grantedPoints ?? 0).toString(),
                    ),
                    buildChip(
                      Assets.icons.popularitySvg,
                      score.popularityScore!.toString().length > 4
                          ? score.popularityScore.toString().substring(0, 4)
                          : score.popularityScore!.toString(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildChip(String svgIconPath, String value) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Chip(
              label: Row(
            children: [
              SvgPicture.asset(
                svgIconPath,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.blue1,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                value,
                style: AppStyles.normalTextStyle.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
