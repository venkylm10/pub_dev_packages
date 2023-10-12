import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/constants/asset_contants.dart';
import 'package:pub_dev_packages/globals/dart_logo.dart';

class PackageTile extends StatelessWidget {
  final String packageName;
  const PackageTile({super.key, required this.packageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppStyles.primaryColor,
        border: Border.all(
          color: AppStyles.primaryColor,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          dartLogo,
          const SizedBox(width: 20),
          Text(
            packageName,
            style: AppStyles.subHeadingStyle.copyWith(
              color: AppStyles.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
