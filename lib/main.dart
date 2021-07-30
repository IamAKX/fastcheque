import 'package:fastcheque/screens/common/login/login_screen.dart';
import 'package:fastcheque/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FastCheque',
      theme: ThemeData(primarySwatch: Colors.indigo).copyWith(
        scaffoldBackgroundColor: bgColor,
        backgroundColor: bgColor,
        primaryColor: primaryColor,
        accentColor: primaryColor,
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
      ),
      home: Login(),
    );
  }
}
