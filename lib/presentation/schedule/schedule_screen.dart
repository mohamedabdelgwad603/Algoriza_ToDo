// ignore_for_file: prefer_const_constructors
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/utils/constants.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/models/task.dart';
import 'package:todo/presentation/board/screens/board_layout_screen.dart';
import 'package:todo/presentation/shared_widget/default_app_bar.dart';
import 'package:todo/presentation/shared_widget/default_button.dart';
import 'package:todo/presentation/shared_widget/default_divider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo/sevices/notification_services.dart';

import '../../core/utils/assets_manger.dart';
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
            BlocProvider.of<AppCubit>(context).getSchudeledTasks();
          }

          var cubit = BlocProvider.of<AppCubit>(context);
          return Scaffold(
            key: scaffoldKey,
            body: Column(
              children: [
                DefaultAppBar(
                  text: 'Schedule',
                  action: cubit.schudeledTasks.isNotEmpty
                      ? DefaultButton(
                          text: 'Delete All',
                          onpressed: () {
                            buildDialog(context, cubit);
                          },
                          height: 43,
                          width: 120,
                        )
                      : null,
                  onPressedArrowBack: () async {
                    await Constants.pushReplace(context, BoardLayoutScreen());
                    cubit.selectedDate = DateTime.now();
                    cubit.getSchudeledTasks();
                  },
                ),
                //Date picker
                DatePickerWidget(),
                DefaultDivider(),
                Expanded(
                    child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
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
                            condition: cubit.schudeledTasks.isNotEmpty,
                            builder: (context) => ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    duration: Duration(milliseconds: 1200),
                                    position: index,
                                    child: SlideAnimation(
                                      horizontalOffset: 300,
                                      child: FadeInAnimation(
                                        child: TaskBuilder(
                                          task: cubit.schudeledTasks.reversed
                                              .toList()[index],
                                          scaffoldKey: scaffoldKey,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 20,
                                    ),
                                itemCount: cubit.schudeledTasks.length),
                            fallback: (context) => Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      ImgAssets.noTaskImg,
                                      height: 200,
                                    ),
                                    Text(
                                      'You do not have any tasks yet!\n Add new Task to make your days productive ',
                                      style: context.bodyText1,
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
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

  void buildDialog(BuildContext context, AppCubit cubit) {
    Get.dialog(CupertinoAlertDialog(
      insetAnimationDuration: Duration(milliseconds: 300),
      title: Text(
        "Are you sure to delete?",
        style: context.subtitle1,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
              text: 'Delete',
              width: null,
              onpressed: () {
                NotifiyHelper.cancelAllNotification();
                cubit.deleteAllTasks();
                Get.back();
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultButton(
              text: 'close',
              width: null,
              onpressed: () {
                Get.back();
              }),
        )
      ],
    ));
  }
}
