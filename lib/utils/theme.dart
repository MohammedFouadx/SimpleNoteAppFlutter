import 'package:flutter/material.dart';

import 'color.dart';

ThemeData themeAppLight() {
  return ThemeData(
    primaryColor: mainColor,
    accentColor: blueColor,
    buttonColor: mainColor,
    brightness: Brightness.light,
   //fontFamily: "abod",
    textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 20.0, color: blueColor, height: 1.35),
      headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: blueColor, height: 1.35),
      headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color:blueColor, height: 1.35),
      headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700, color: blueColor, height: 1.35),
      headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: blueColor, height: 1.5),
      subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600, color: blueColor, height: 1.35),
      subtitle2: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, color: blueColor, height: 1.35),
      headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: mainColor, height: 1.35),
      bodyText2: TextStyle(fontSize: 14.0, color:blueColor, height: 1.35),
      bodyText1: TextStyle(fontSize: 14.0, color: blueColor, height: 1.35),
      caption: TextStyle(fontSize: 12.0, color:blueColor, height: 1.35),
    ),
  );
}
ThemeData themeAppDark() {
  return ThemeData(
    primaryColor: dartMainColor,
    accentColor: blueColor,
    buttonColor: mainColor,
    brightness: Brightness.dark,
  //   fontFamily: "abod",
    textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 20.0, color: mainColor, height: 1.35),
      headline4: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: mainColor, height: 1.35),
      headline3: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color:mainColor, height: 1.35),
      headline2: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, color: mainColor, height: 1.35),
      headline1: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300, color: mainColor, height: 1.5),
      subtitle1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: mainColor, height: 1.35),
      headline6: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: mainColor, height: 1.35),
      bodyText2: TextStyle(fontSize: 12.0, color:mainColor, height: 1.35),
      bodyText1: TextStyle(fontSize: 14.0, color: mainColor, height: 1.35),
      caption: TextStyle(fontSize: 12.0, color:mainColor, height: 1.35),
    ),
  );
}
