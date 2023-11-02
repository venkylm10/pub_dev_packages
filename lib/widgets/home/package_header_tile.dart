import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pub_dev_packages/constants/assets.dart';
import 'package:pub_dev_packages/constants/colors.dart';
import 'package:pub_dev_packages/constants/styles.dart';
import 'package:pub_dev_packages/globals/dart_logo.dart';
import 'package:pub_dev_packages/models/package_model/matrics/score.dart';
import 'package:pub_dev_packages/pages/home/favourites_controller.dart';

class PackageHeaderTile extends ConsumerWidget {
  final int packageIndex;
  final bool? showPlatforms;
  const PackageHeaderTile({
    required this.packageIndex,
    this.showPlatforms = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final package =
        ref.read(favPackagesProvider.notifier).favoritePackages[packageIndex];
    final score =
        ref.watch(favPackagesProvider.notifier).favScores[packageIndex];
    final tags =
        ref.watch(favPackagesProvider.notifier).favScores[packageIndex].tags;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
          .copyWith(right: 20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        border: Border.all(
          color: AppColors.primaryColor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          dartLogo,
          const SizedBox(width: 12),
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
                Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  clipBehavior: Clip.hardEdge,
                  children: [
                    buildChip(
                      value: package.latest.version,
                      style: AppStyles.smallTextStyle.copyWith(
                        color: AppColors.blue1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    buildChip(
                      value: "null-safe",
                      style: AppStyles.smallTextStyle.copyWith(
                        color: !isNullSafe(tags ?? [])
                            ? AppColors.redColor
                            : AppColors.blue1,
                        fontWeight: FontWeight.w600,
                        decoration: !isNullSafe(tags ?? [])
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    buildChip(
                      value: "Dart 3 compatible",
                      style: AppStyles.smallTextStyle.copyWith(
                        color: !isDart3Compatible(tags ?? [])
                            ? AppColors.redColor
                            : AppColors.blue1,
                        fontWeight: FontWeight.w600,
                        decoration: !isDart3Compatible(tags ?? [])
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                Text(
                  package.latest.pubspec.description.trim(),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.normalTextStyle,
                ),
                buildPlatformChips(tags),
                buildScoreChips(score),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Wrap buildScoreChips(Score score) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        buildChip(
          svgIconPath: Assets.icons.likesSvg,
          value: (score.likeCount ?? 0).toString(),
        ),
        buildChip(
          svgIconPath: Assets.icons.pointsSvg,
          value: (score.grantedPoints ?? 0).toString(),
        ),
        buildChip(
          svgIconPath: Assets.icons.popularitySvg,
          value: score.popularityScore!.toString().length > 4
              ? score.popularityScore.toString().substring(0, 4)
              : score.popularityScore!.toString(),
        ),
      ],
    );
  }

  Wrap buildPlatformChips(List<String>? tags) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        if (supportsAndroid(tags!))
          buildChip(
            svgIconPath: Assets.icons.androidSvg,
          ),
        if (supportsIos(tags))
          buildChip(
            svgIconPath: Assets.icons.iosSvg,
            iconHeight: 11,
          ),
        if (supportsWeb(tags))
          buildChip(
            svgIconPath: Assets.icons.webSvg,
          ),
        if (supportsLinux(tags))
          buildChip(
            svgIconPath: Assets.icons.linuxSvg,
          ),
        if (supportsWindows(tags))
          buildChip(
            svgIconPath: Assets.icons.windowsSvg,
          ),
        if (supportsMacos(tags))
          buildChip(
            svgIconPath: Assets.icons.macOs,
            iconHeight: 11,
          ),
      ],
    );
  }

  Container buildChip({
    String? svgIconPath,
    double? iconHeight,
    String? value,
    TextStyle? style,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.only(right: 10),
      child: Chip(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (svgIconPath != null)
              SvgPicture.asset(
                svgIconPath,
                height: iconHeight ?? 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.blue1,
                  BlendMode.srcIn,
                ),
              ),
            if (value != null && svgIconPath != null) const SizedBox(width: 5),
            if (value != null)
              Text(
                value,
                style: style ??
                    AppStyles.normalTextStyle.copyWith(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
