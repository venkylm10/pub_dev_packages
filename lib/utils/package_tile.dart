import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/constants/asset_contants.dart';

class PackageTile extends StatelessWidget {
  final String packageName;
  const PackageTile({super.key, required this.packageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 45,
      decoration: BoxDecoration(
        color: AppStyles.primaryColor,
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AssetContants.dartLogo,
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 20),
          Text(packageName),
        ],
      ),
    );
  }
}
