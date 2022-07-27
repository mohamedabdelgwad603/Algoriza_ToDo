// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/task.dart';
import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../widgets/conditional_builder_tasks.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Task>? tasks =
              BlocProvider.of<AppCubit>(context).allTasks.reversed.toList();

          return ConditionalBuilderTasks(tasks: tasks);
        });
  }
}
