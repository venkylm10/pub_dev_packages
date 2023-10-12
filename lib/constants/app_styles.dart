import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static const backgroundColor = Color.fromARGB(255, 8, 8, 8);
  static const primaryColor = Color.fromARGB(255, 31, 29, 29);
  static const secondaryColor = Color.fromARGB(255, 41, 40, 40);
  static const whiteColor = Color.fromARGB(255, 211, 201, 201);
  static const blue1 = Color(0xff3bbcf4);
  static const blue2 = Color(0xff0466C8);
  static const blue3 = Color(0xff0353A4);
  static const blue4 = Color(0xff023E7D);
  static const darkBlue1 = Color(0xff002855);
  static const darkBlue2 = Color(0xff001845);
  static const darkBlue3 = Color(0xff001233);

  static final headingStyle = GoogleFonts.nunitoSans(
    fontSize: 26,
    color: blue1,
    fontWeight: FontWeight.bold,
  );
  static final subHeadingStyle = GoogleFonts.nunitoSans(
    fontSize: 18,
    color: blue1,
    fontWeight: FontWeight.bold,
  );
  static final normalTextStyle = GoogleFonts.nunitoSans(
    fontSize: 14,
    color: whiteColor,
    fontWeight: FontWeight.normal,
  );
}
