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
}
