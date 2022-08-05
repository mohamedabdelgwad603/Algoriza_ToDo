import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../models/task.dart';
import '../widgets/conditional_builder_tasks.dart';

class FavouriteTasksScreen extends StatelessWidget {
  const FavouriteTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          List<Task>? favouritesTasks = BlocProvider.of<AppCubit>(context)
              .favouritesTasks
              .reversed
              .toList();

          return ConditionalBuilderTasks(
            tasks: favouritesTasks,
            isFavourite: true,
          );
        });
  }
}
