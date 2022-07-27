// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppBorderStyles {
  static OutlineInputBorderStyle() {
    return OutlineInputBorder(
        // ignore: prefer_const_constructors
        borderSide: BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(8.0));
  }
}
