import 'package:flutter/material.dart';

final stadtnaviTheme = ThemeData(
  primaryColor: const Color(0xffE1011A),
  primaryColorLight: const Color(0xffeceff1),
  accentColor: Color(0xff003063),
  backgroundColor: Colors.white,
  dividerColor: Color(0xff333333),
  textTheme: ThemeData.light().textTheme.copyWith(
        bodyText1: const TextStyle(color: Color(0xFF333333)),
        bodyText2: const TextStyle(color: Color(0xff003063)),
        headline6: const TextStyle(color: Colors.white),
        subtitle1: const TextStyle(color: Color(0xff747474)),
      ),
  primaryTextTheme: ThemeData.light().primaryTextTheme.copyWith(
        headline6: const TextStyle(color: Colors.white),
        subtitle1: const TextStyle(color: Colors.white),
      ),
  primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
        color: const Color(0xFFFDFDFE),
      ),
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: const Color(0xFFE1011A).withOpacity(0.5),
    cursorColor: const Color(0xffE1011A),
    selectionHandleColor: const Color(0xffE1011A),
  ),
);

final bottomBarTheme = ThemeData(
  primaryColor: const Color(0xff003063),
  accentColor: Color(0xff003063),
  backgroundColor: Colors.white,
  textTheme: ThemeData.light().textTheme.copyWith(
        bodyText1: const TextStyle(color: Color(0xFF333333), fontSize: 19),
        bodyText2: const TextStyle(color: Color(0xff003063), fontSize: 19),
        headline6: const TextStyle(color: Colors.white, fontSize: 19),
        subtitle1: const TextStyle(color: Color(0xff747474), fontSize: 19),
      ),
  primaryTextTheme: ThemeData.light().primaryTextTheme.copyWith(
        bodyText1: const TextStyle(color: Color(0xFF000000), fontSize: 15),
        bodyText2: const TextStyle(color: Color(0xff003063), fontSize: 15),
        headline6: const TextStyle(color: Colors.white, fontSize: 15),
        subtitle1: const TextStyle(color: Colors.white, fontSize: 15),
      ),
  primaryIconTheme: ThemeData.light().primaryIconTheme.copyWith(
        color: const Color(0xff003063),
      ),
  accentIconTheme: ThemeData.light().primaryIconTheme.copyWith(
        color: Colors.black,
      ),
);
