// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

class Themes {
  // static bool? isDark;
  // static ThemeMode themeMode =
  //     isDark == true ? ThemeMode.dark : ThemeMode.light;

  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.black,
      primarySwatch: Colors.teal,
      //brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      // fontFamily: AppStrings.fontFamily,
      textTheme: TextTheme(
          caption: TextStyle(fontSize: 18, color: Colors.grey[300]),
          button: TextStyle(
              color: Colors.black.withOpacity(.5),
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.fontFamily),
          subtitle1: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: AppStrings.fontFamily),
          subtitle2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: AppStrings.fontFamily),
          bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              fontFamily: AppStrings.fontFamily)));

  static ThemeData darkTheme = ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.black,
      //  brightness: Brightness.dark,
      // fontFamily: AppStrings.fontFamily,
      textTheme: TextTheme(
          caption: TextStyle(fontSize: 18, color: Colors.white),
          button: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: AppStrings.fontFamily),
          subtitle1: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppStrings.fontFamily),
          subtitle2: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: AppStrings.fontFamily),
          bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontFamily: AppStrings.fontFamily)));
}
