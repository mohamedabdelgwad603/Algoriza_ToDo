// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_strings.dart';

ThemeData appTheme = ThemeData(
    primaryColor: AppColors.primary,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    // fontFamily: AppStrings.fontFamily,
    textTheme: TextTheme(
        button: TextStyle(
            color: Colors.white,
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
