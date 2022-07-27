import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/models/task.dart';
import 'package:todo/presentation/shared_widget/default_button.dart';
import 'package:todo/presentation/shared_widget/default_divider.dart';

import '../../../core/utils/app_colors.dart';
import '../../../cubit/cubit.dart';

class TaskBuilder extends StatelessWidget {
  TaskBuilder({
    Key? key,
    required this.scaffoldKey,
    required this.task,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Task task;
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AppCubit>(context);
    //cubit.formarRepeatTasks();
    // if (task.repeat == 'Daily' ||
    //     task.date == DateFormat('yyyy-MM-dd').format(cubit.selectedTime)) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: task.color == 'red'
              ? AppColors.redColor.withOpacity(.7)
              : task.color == "blue"
                  ? AppColors.blueColor
                  : task.color == 'orange'
                      ? AppColors.orangeColor
                      : AppColors.yelColor,
          borderRadius: BorderRadius.circular(25)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 3,
          child: Container(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${task.startTime} - ${task.endTime}",
                  style: context.subtitle2!.copyWith(color: Colors.white),
                ),
                Text(
                  "${task.title} ",
                  overflow: TextOverflow.ellipsis,
                  style: context.bodyText1!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              showBottomSheetFunction(cubit);
            },
            child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: task.isCompleted == 1
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 18,
                    )
                  : null,
            ),
          ),
        )
      ]),
    );
    // } else {
    //   return SizedBox();
    // }
  }

  showBottomSheetFunction(AppCubit cubit) {
    scaffoldKey.currentState?.showBottomSheet(
        (context) => Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        if (task.isCompleted != 1)
                          DefaultButton(
                              text: 'completed',
                              color: AppColors.redColor,
                              onpressed: () {
                                cubit.updateCompleted(
                                  isCompleted: 1,
                                  id: task.id as int,
                                );

                                Navigator.pop(context);
                              }),
                        SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                            text: 'Delete',
                            color: AppColors.blueColor,
                            onpressed: () {
                              cubit.deleteTask(id: task.id as int);
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        DefaultButton(
                            text: task.isFavourite != 1
                                ? 'Add to favourites'
                                : 'Remove from favourites',
                            color: AppColors.orangeColor,
                            onpressed: () {
                              cubit.updateFavourite(
                                  id: task.id as int,
                                  isFavourite: task.isFavourite == 0 ? 1 : 0);
                              Navigator.pop(context);
                            }),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  DefaultDivider(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: DefaultButton(
                        text: 'close',
                        color: Colors.white,
                        textColor: Colors.black,
                        isBorder: true,
                        onpressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
        elevation: 50,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.white);
  }
}
