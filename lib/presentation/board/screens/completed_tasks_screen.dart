import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../models/task.dart';
import '../widgets/conditional_builder_tasks.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Task>? completedTasks = BlocProvider.of<AppCubit>(context)
              .completedTasks
              .reversed
              .toList();

          return ConditionalBuilderTasks(tasks: completedTasks);
        });
  }
}
