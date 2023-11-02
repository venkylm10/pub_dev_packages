import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pub_dev_packages/constants/colors.dart';

class AppStyles {
  static final headingStyle = GoogleFonts.poppins(
    fontSize: 26,
    color: AppColors.blue1,
    fontWeight: FontWeight.bold,
  );
  static final subHeadingStyle = GoogleFonts.poppins(
    fontSize: 18,
    color: AppColors.blue1,
    fontWeight: FontWeight.bold,
  );
  static final normalTextStyle = GoogleFonts.poppins(
    fontSize: 14,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
  static final smallTextStyle = GoogleFonts.poppins(
    fontSize: 12,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.normal,
  );
}
