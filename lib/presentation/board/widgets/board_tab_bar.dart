// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';
import '../../../core/utils/app_strings.dart';

class BoardTabBar extends StatelessWidget {
  const BoardTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
        padding: EdgeInsets.zero,
        indicatorPadding: EdgeInsets.zero,
        labelColor: context.primaryColor,
        labelStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontFamily: AppStrings.fontFamily,
            fontSize: 16),
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 2.0, color: context.primaryColor),
            insets: EdgeInsets.symmetric(horizontal: 37.0, vertical: 0)),
        labelPadding: EdgeInsets.zero,
        // ignore: prefer_const_literals_to_create_immutables
        tabs: [
          Tab(
            text: 'All',
          ),
          Tab(
            text: 'Completed',
          ),
          Tab(
            text: 'Uncompleted',
          ),
          Tab(
            text: 'favourite',
          ),
        ]);
  }
}
