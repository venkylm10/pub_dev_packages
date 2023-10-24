import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pub_dev_packages/constants/colors.dart';

class AppStyles {
  static final headingStyle = GoogleFonts.nunitoSans(
    fontSize: 26,
    color: AppColors.blue1,
    fontWeight: FontWeight.bold,
  );
  static final subHeadingStyle = GoogleFonts.nunitoSans(
    fontSize: 18,
    color: AppColors.blue1,
    fontWeight: FontWeight.bold,
  );
  static final normalTextStyle = GoogleFonts.nunitoSans(
    fontSize: 14,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
}
