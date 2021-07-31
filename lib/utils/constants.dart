import 'package:fastcheque/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultPadding = 16;

ThemeData globalTheme(BuildContext context) {
  return ThemeData(primarySwatch: Colors.indigo).copyWith(
    scaffoldBackgroundColor: bgColor,
    backgroundColor: bgColor,
    primaryColor: primaryColor,
    accentColor: primaryColor,
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: primaryColor,
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: primaryColor,
      alignLabelWithHint: false,
      filled: true,
      hoverColor: primaryColor,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: primaryColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide(color: hintColor),
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      Theme.of(context).textTheme,
    ).apply(
      bodyColor: textColor,
      displayColor: hintColor,
    ),
    canvasColor: secondaryColor,
  );
}
