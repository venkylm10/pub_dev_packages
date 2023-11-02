import 'package:flutter/material.dart';
import 'package:pub_dev_packages/constants/colors.dart';
import 'package:pub_dev_packages/constants/assets.dart';

final dartLogo = Container(
  height: 40,
  width: 40,
  decoration: BoxDecoration(
    color: AppColors.darkBlue3,
    borderRadius: BorderRadius.circular(20),
  ),
  child: Center(
    child: Image.asset(
      Assets.icons.dartLogo,
      height: 20,
      width: 20,
    ),
  ),
);
