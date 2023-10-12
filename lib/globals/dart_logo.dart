import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/app_styles.dart';
import 'package:pub_dev_packages/constants/asset_contants.dart';

final dartLogo = Container(
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
);
