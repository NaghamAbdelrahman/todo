import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xff5D9CEC);
  static const Color lightScaffoldBackgroundColor = Color(0xffDFECDB);
  static const Color grey = Color(0xffC8C9CB);
  static const Color green = Color(0xff61E757);
  static final lightTheme = ThemeData(
    primaryColor: lightPrimary,
    appBarTheme: const AppBarTheme(
      color: lightPrimary,
      titleTextStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
      centerTitle: true,
    ),
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: lightPrimary, size: 36),
        unselectedIconTheme: IconThemeData(color: grey, size: 36)),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPrimary,
      shape: StadiumBorder(side: BorderSide(width: 4, color: Colors.white)),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(18), topLeft: Radius.circular(18)))),
    textTheme: const TextTheme(
      headline5: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      headline6: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: lightPrimary,
    )),
  );
}
