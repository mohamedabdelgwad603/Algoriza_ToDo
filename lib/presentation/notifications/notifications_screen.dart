// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:todo/config/styles/icon_broken.dart';
import 'package:todo/core/utils/app_colors.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/presentation/shared_widget/default_app_bar.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key, required this.payload})
      : super(key: key);
  final String payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        DefaultAppBar(
          text: 'Notification',
          onPressedArrowBack: () {
            Navigator.pop(context);
          },
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "Hello",
          style: context.subtitle1,
        ),
        Text(
          "You have a new reminder",
          style: context.bodyText1,
        ),
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.primary),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Icon(
                      Icons.text_format,
                      size: 30,
                      color: context.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Title',
                        style: context.subtitle1?.copyWith(color: Colors.white),
                        // overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    payload.split('|')[0],
                    style: context.bodyText1?.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Icon(
                      Icons.description,
                      size: 30,
                      color: context.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Description ',
                        style: context.subtitle1?.copyWith(color: Colors.white),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    payload.split('|')[1],
                    style: context.bodyText1?.copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(children: [
                    Icon(
                      IconBroken.Calendar,
                      size: 30,
                      color: context.primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        'Date',
                        style: context.subtitle1?.copyWith(color: Colors.white),
                      ),
                    )
                  ]),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    payload.split('|')[2],
                    style: context.bodyText1?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
