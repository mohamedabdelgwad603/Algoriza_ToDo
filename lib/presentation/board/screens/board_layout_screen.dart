// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/utils/constants.dart';
import 'package:todo/presentation/add_task/add_task_screen.dart';

import 'package:todo/presentation/board/widgets/board_app_bar.dart';

import 'package:todo/presentation/board/widgets/defualt_tab_controller_widget.dart';
import 'package:todo/presentation/shared_widget/default_button.dart';
import 'package:todo/presentation/shared_widget/default_divider.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

class BoardLayoutScreen extends StatelessWidget {
  BoardLayoutScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var blocConsumer = BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scaffoldState,
            endDrawer: Drawer(),
            body: Column(children: [
              BoardAppBar(
                scaffoldState: scaffoldState,
              ),
              DefaultDivider(),
              //DefaultTabController
              Expanded(
                child: DefaultTabControllerWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultButton(
                  text: "Add a task",
                  onpressed: () {
                    Constants.push(context, AddTaskScreen());
                  },
                ),
              )
            ]),
          );
        });
    return blocConsumer;
  }
}
