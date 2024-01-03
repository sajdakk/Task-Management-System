import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class ThTextStyles {
  static final paragraphP2Medium = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 20 / 14,
    letterSpacing: 0,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );

    static const paragraphP3Medium = TextStyle(
    fontSize: 12,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    height: 18 / 12,
    letterSpacing: 0,
    fontFamily: 'Poppins',
  );

    static const textCategory = TextStyle(
    fontSize: 15,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 15 / 15,
    letterSpacing: 0.02,
    fontFamily: 'Poppins',
  );

    static const textButtonBig = TextStyle(
    fontSize: 14,
    decoration: TextDecoration.none,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    height: 24 / 14,
    letterSpacing: 0,
    fontFamily: 'Poppins',
  );
}
