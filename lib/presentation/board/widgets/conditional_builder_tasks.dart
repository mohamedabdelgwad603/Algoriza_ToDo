import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';

import '../../../core/utils/app_colors.dart';
import '../../../models/task.dart';

class ConditionalBuilderTasks extends StatelessWidget {
  const ConditionalBuilderTasks({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  final List<Task>? tasks;

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: tasks!.isNotEmpty,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: tasks!.length,
          itemBuilder: (context, index) => Row(
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
                              : tasks![index].color == 'orange'
                                  ? AppColors.orangeColor
                                  : AppColors.yelColor)
                      : null,
                  border: Border.all(
                      color: tasks![index].color == 'red'
                          ? AppColors.redColor
                          : tasks![index].color == 'blue'
                              ? AppColors.blueColor
                              : tasks![index].color == 'orange'
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
              )
            ],
          ),
          separatorBuilder: (context, index) => SizedBox(
            height: 20,
          ),
        ),
      ),
      fallback: (context) => Center(
        child: Text('not found'),
      ),
    );
  }
}
