// ignore_for_file: prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/utils/constants.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/models/task.dart';
import 'package:todo/presentation/board/screens/board_layout_screen.dart';
import 'package:todo/presentation/shared_widget/default_app_bar.dart';
import 'package:todo/presentation/shared_widget/default_divider.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import 'widgets/build_date_picker.dart';
import 'widgets/task_builder.dart';

class ScheduleScreen extends StatelessWidget {
  ScheduleScreen({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetFromDataBaseState || state is GetselectedDateState) {
            BlocProvider.of<AppCubit>(context).getTasksAfterFiltration();
          }

          var cubit = BlocProvider.of<AppCubit>(context);
          return Scaffold(
            key: scaffoldKey,
            body: Column(
              children: [
                DefaultAppBar(
                  text: 'Schedule',
                  onPressedArrow: () {
                    Constants.pushReplace(context, BoardLayoutScreen());
                  },
                ),
                //Date picker
                DatePickerWidget(),
                DefaultDivider(),
                Expanded(
                    child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE')
                                  .format(cubit.selectedDate)
                                  .toString(),
                              style: context.subtitle2,
                            ),
                            Text(
                              DateFormat.yMMMd()
                                  .format(cubit.selectedDate)
                                  .toString(),
                              style: context.bodyText1,
                            )
                          ],
                        ),
                        ConditionalBuilder(
                            condition: cubit.filteredTasks.isNotEmpty,
                            builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => TaskBuilder(
                                      task: cubit.filteredTasks.reversed
                                          .toList()[index],
                                      scaffoldKey: scaffoldKey,
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 20,
                                    ),
                                itemCount: cubit.filteredTasks.length),
                            fallback: (context) => Center(
                                  child: Text("not found "),
                                ))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          );
        });
  }
}
