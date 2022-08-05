// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:todo/core/utils/assets_manger.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/presentation/shared_widget/default_button.dart';

import '../../../core/utils/app_colors.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../models/task.dart';

class ConditionalBuilderTasks extends StatelessWidget {
  const ConditionalBuilderTasks({
    Key? key,
    required this.tasks,
    this.isFavourite = false,
  }) : super(key: key);

  final List<Task>? tasks;
  final bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: tasks!.isNotEmpty,
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemCount: tasks!.length,
                    itemBuilder: (context, index) =>
                        AnimationConfiguration.staggeredList(
                      position: index,
                      duration: Duration(milliseconds: 1000),
                      child: SlideAnimation(
                        //  horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: InkWell(
                            onTap: () {
                              buildDialog(index, context);
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: tasks![index].isCompleted == 1
                                        ? (tasks![index].color == 'red'
                                            ? AppColors.redColor
                                            : tasks![index].color == 'blue'
                                                ? AppColors.blueColor
                                                : tasks![index].color ==
                                                        'orange'
                                                    ? AppColors.orangeColor
                                                    : AppColors.yelColor)
                                        : null,
                                    border: Border.all(
                                        color: tasks![index].color == 'red'
                                            ? AppColors.redColor
                                            : tasks![index].color == 'blue'
                                                ? AppColors.blueColor
                                                : tasks![index].color ==
                                                        'orange'
                                                    ? AppColors.orangeColor
                                                    : AppColors.yelColor,
                                        style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: tasks![index].isCompleted == 1
                                      ? Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    "${tasks![index].title} ",
                                    style: context.bodyText1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 20,
                    ),
                  ),
                );
              },
              fallback: (context) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        size: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "You do not have any tasks yet!",
                        style: context.subtitle2,
                      )
                    ],
                  )
              // Center(
              //   child: Image.asset(
              //     ImgAssets.noTaskImg,
              //     height: 200,
              //   ),
              // ),
              );
        });
  }

  void buildDialog(int index, BuildContext context) {
    Get.dialog(CupertinoAlertDialog(
      insetAnimationDuration: Duration(milliseconds: 300),
      title: Text(
        "${tasks![index].title}",
        style: context.subtitle1,
      ),
      content: Text(
        "Added at ${tasks![index].date}",
        style: context.bodyText1,
      ),
      actions: [
        isFavourite
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                    text: 'Remove',
                    onpressed: () {
                      context.cubit.updateFavourite(
                          isFavourite: 0, id: tasks![index].id!);
                      Get.back();
                    }),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: DefaultButton(
                    text: 'Delete',
                    onpressed: () {
                      context.cubit.deleteTask(id: tasks![index].id!);
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
