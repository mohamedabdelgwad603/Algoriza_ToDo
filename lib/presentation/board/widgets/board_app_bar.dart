// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo/core/utils/constants.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/presentation/schedule/schedule_screen.dart';

import '../../../config/styles/icon_broken.dart';

class BoardAppBar extends StatelessWidget {
  const BoardAppBar({Key? key, required this.scaffoldState}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: EdgeInsets.all(20.0) - EdgeInsets.only(bottom: 10.0),
          child: Row(
            children: [
              Text("Board", style: context.subtitle1),
              Spacer(),
              MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 1,
                  onPressed: () {},
                  child: Icon(
                    IconBroken.Search,
                    size: 28,
                  )),
              MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 1,
                  onPressed: () {},
                  child: Icon(
                    IconBroken.Notification,
                    size: 28,
                  )),
              MaterialButton(
                  minWidth: 1,
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Constants.push(context, ScheduleScreen());
                  },
                  child: Icon(
                    IconBroken.Calendar,
                    size: 28,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
