import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeDataDark = ThemeData(
  platform: Platform.isAndroid ? TargetPlatform.android : TargetPlatform.iOS,
  useMaterial3: true,
  primaryColor: const Color(0xFF3CBEAA),
  primarySwatch: const MaterialColor(0xFF3CBEAA, {
    50: Color.fromRGBO(60, 190, 170, .1),
    100: Color.fromRGBO(60, 190, 170, .2),
    200: Color.fromRGBO(60, 190, 170, .3),
    300: Color.fromRGBO(60, 190, 170, .4),
    400: Color.fromRGBO(60, 190, 170, .5),
    500: Color.fromRGBO(60, 190, 170, .6),
    600: Color.fromRGBO(60, 190, 170, .7),
    700: Color.fromRGBO(60, 190, 170, .8),
    800: Color.fromRGBO(60, 190, 170, .9),
    900: Color.fromRGBO(60, 190, 170, 1),
  }),
  scaffoldBackgroundColor: const Color(0xFF203745),
  textTheme: TextTheme(
    titleLarge:
        baseTextStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium:
        baseTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
    bodyLarge: baseTextStyle.copyWith(fontSize: 20.0),
    bodyMedium: baseTextStyle,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF3CBEAA),
      disabledBackgroundColor: const Color(0xFF3CBEAA).withOpacity(0.7),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      shadowColor: const Color(0xFF000000).withOpacity(0.32),
      textStyle: baseTextStyle.copyWith(),
    ),
  ),
);

final baseTextStyle = GoogleFonts.karla(
  color: const Color(0xFFFFFFFF),
  fontWeight: FontWeight.normal,
  fontSize: 16.0,
);

class ThemeColors {
  static const Color offWhite = Color(0xFFE3ECF2);
  static const Color offWhite2 = Color(0xFFC7DAE5);
  static const Color offWhite3 = Color(0xFFABC7D8);
  static const Color inputFillColor = Color(0xFF477A9A);
}
