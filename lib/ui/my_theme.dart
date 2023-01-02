import 'package:flutter/material.dart';

class MyTheme {
  static const Color appPrimary = Color(0xff5D9CEC);
  static const Color lightScaffoldBackgroundColor = Color(0xffDFECDB);
  static const Color grey = Color(0xffC8C9CB);
  static const Color green = Color(0xff61E757);
  static const Color darkScaffoldBackgroundColor = Color(0xff060E1E);
  static const Color navyBlue = Color(0xff141922);
  static final lightTheme = ThemeData(
    primaryColor: appPrimary,
    accentColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: appPrimary,
      titleTextStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: appPrimary, size: 36),
        unselectedIconTheme: IconThemeData(color: grey, size: 36)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appPrimary,
      shape: StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)))),
    textTheme: const TextTheme(
      headline4: TextStyle(fontSize: 28, color: Colors.black),
      headline5: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      headline6: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      subtitle1: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: appPrimary,
    )),
  );
  static final darkTheme = ThemeData(
    primaryColor: appPrimary,
    accentColor: navyBlue,
    appBarTheme: const AppBarTheme(
        elevation: 0,
        color: appPrimary,
        titleTextStyle: TextStyle(
            fontSize: 21, fontWeight: FontWeight.bold, color: navyBlue),
        centerTitle: true,
        iconTheme: IconThemeData(color: navyBlue)),
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: appPrimary, size: 36),
        unselectedIconTheme: IconThemeData(color: grey, size: 36)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: appPrimary,
      shape: StadiumBorder(side: BorderSide(width: 4, color: navyBlue)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: navyBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)))),
    textTheme: const TextTheme(
      headline4: TextStyle(fontSize: 28, color: Colors.white),
      headline5: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      headline6: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      subtitle1: TextStyle(color: Colors.white),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: appPrimary,
    )),
  );
}
