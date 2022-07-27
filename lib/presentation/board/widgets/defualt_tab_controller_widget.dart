// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../shared_widget/default_divider.dart';
import '../screens/all_tasks_screen.dart';
import '../screens/completed_tasks_screen.dart';
import '../screens/favourite_tasks_screen.dart';
import '../screens/uncompleted_tasks_screen.dart';
import 'board_tab_bar.dart';

class DefaultTabControllerWidget extends StatelessWidget {
  const DefaultTabControllerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //tabBar
            BoardTabBar(),
            DefaultDivider(),
            //TabBarView
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  height: 400,
                  // ignore: prefer_const_literals_to_create_immutables
                  child: TabBarView(children: [
                    AllTasksScreen(),
                    CompletedTasksScreen(),
                    UnCompletedTasksScreen(),
                    FavouriteTasksScreen()
                  ]),
                ),
              ),
            )
          ],
        ));
  }
}
