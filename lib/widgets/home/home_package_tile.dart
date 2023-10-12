import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/constants/asset_contants.dart';
import 'package:pub_dev_packages/models/package_model/package_model.dart';

class HomePackageTile extends StatelessWidget {
  final Package package;
  const HomePackageTile({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    final packageName = package.name.length > 25
        ? '${package.name.substring(0, 25)} . .'
        : package.name;
    final sdkVersion = package.latest.pubspec.environment?.sdk ?? '';
    final flutterVersion = package.latest.pubspec.environment?.flutter ?? '';
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)
          .copyWith(right: 20),
      decoration: BoxDecoration(
        color: AppStyles.primaryColor,
        border: Border.all(
          color: AppStyles.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: AppStyles.darkBlue3,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Image.asset(
                AssetContants.dartLogo,
                height: 20,
                width: 20,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  packageName,
                  overflow: TextOverflow.fade,
                  style: AppStyles.subHeadingStyle
                      .copyWith(color: AppStyles.whiteColor),
                ),
                Text(
                  package.latest.version,
                  style: AppStyles.normalTextStyle.copyWith(
                    color: AppStyles.blue1,
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
                          color: AppStyles.blue1,
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
                          color: AppStyles.blue1,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
