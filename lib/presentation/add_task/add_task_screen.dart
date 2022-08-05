// ignore_for_file: prefer_const_constructors, unused_element, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'package:todo/presentation/add_task/widgets/default_text_field.dart';
import 'package:todo/presentation/shared_widget/default_app_bar.dart';
import 'package:todo/presentation/shared_widget/default_button.dart';

import '../../config/styles/icon_broken.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/constants.dart';
import '../schedule/schedule_screen.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController dateController = TextEditingController(
      text: DateFormat('yyyy-MM-dd').format(DateTime.now()));

  TextEditingController startTimeController =
      TextEditingController(text: DateFormat('hh:mm a').format(DateTime.now()));

  TextEditingController endTimeController = TextEditingController(
      text: DateFormat('hh:mm a')
          .format(DateTime.now().add(Duration(minutes: 15))));

  TextEditingController remindController =
      TextEditingController(text: '0 minutes early');

  TextEditingController repeatController = TextEditingController(text: 'none');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isRed = true;
  bool isYellow = false;
  bool isBlue = false;
  bool isOrange = false;

  List<int> remindItems = [0, 5, 10, 15, 20];

  List<String> repeatItems = ['none', 'Daily', 'Weekly', 'Monthly'];

  String test = 'test';
  @override
  // initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  //   startTimeController.text =
  //       TimeOfDay.fromDateTime(DateTime.parse(TimeOfDay.now().toString()))
  //           .format(context);

  //   endTimeController.text =
  //       TimeOfDay.fromDateTime(DateTime.parse(TimeOfDay.now().toString()))
  //           .format(context);
  //   remindController.text = 'none';
  //   repeatController.text = 'none';
  // }

  @override
  Widget build(BuildContext context) {
    // Add listeners to this class

    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BlocProvider.of<AppCubit>(context);
          return Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                DefaultAppBar(
                  text: 'Add task',
                  onPressedArrowBack: () {
                    Navigator.pop(context);
                  },
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 10, top: 15, bottom: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //title
                            Text("Title", style: context.subtitle2),
                            DefaultFormField(
                                controller: titleController,
                                inputType: TextInputType.name,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Task name must not be empty";
                                  }
                                  return null;
                                },
                                hint: 'Add a task title'),
                            SizedBox(
                              height: 20,
                            ),
                            //date
                            Text("Date", style: context.subtitle2),
                            DefaultFormField(
                              controller: dateController,
                              inputType: TextInputType.datetime,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Date must not be empty";
                                }
                                return null;
                              },
                              // onChange: (value) {
                              //   dateController.text = value;
                              // },
                              widget: IconButton(
                                  onPressed: () {
                                    showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime.now(),
                                            lastDate: DateTime(2101))
                                        .then((value) {
                                      if (value != null) {
                                        dateController.text =
                                            DateFormat('yyyy-MM-dd')
                                                .format(value);
                                      }
                                    });
                                  },
                                  icon: Icon(
                                    IconBroken.Calendar,
                                    color: Colors.grey[400],
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //time
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Start time",
                                            style: context.subtitle2),
                                        DefaultFormField(
                                          controller: startTimeController,
                                          inputType: TextInputType.text,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return "invalid";
                                            }
                                            return null;
                                          },
                                          widget: IconButton(
                                            icon: Icon(
                                              Icons.watch_later_outlined,
                                              color: Colors.grey[400],
                                            ),
                                            onPressed: () {
                                              showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                              ).then((timeofDay) {
                                                if (timeofDay != null) {
                                                  startTimeController.text =
                                                      timeofDay.format(context);
                                                }
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("End time",
                                            style: context.subtitle2),
                                        DefaultFormField(
                                            controller: endTimeController,
                                            inputType: TextInputType.text,
                                            validate: (value) {
                                              if (value!.isEmpty) {
                                                return "invalid";
                                              }
                                              return null;
                                            },
                                            widget: IconButton(
                                                icon: Icon(
                                                  Icons.watch_later_outlined,
                                                  color: Colors.grey[400],
                                                ),
                                                onPressed: () {
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now(),
                                                  ).then((timeofDay) {
                                                    if (timeofDay != null) {
                                                      endTimeController.text =
                                                          timeofDay
                                                              .format(context);
                                                    }
                                                  });
                                                }))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //Remind
                            Text("Remind", style: context.subtitle2),
                            DefaultFormField(
                                controller: remindController,
                                inputType: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Remind must not be empty";
                                  }
                                  return null;
                                },
                                // ignore: prefer_const_literals_to_create_immutables
                                widget: DropdownButton<dynamic>(
                                    style: context.bodyText1,
                                    icon: Icon(IconBroken.Arrow___Down_2),
                                    underline: Container(),
                                    items: remindItems
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text('$e minutes early'),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      remindController.text =
                                          '$value' ' minutes early';
                                    })),
                            SizedBox(
                              height: 20,
                            ),
                            //Repeat
                            Text("Repeat", style: context.subtitle2),
                            DefaultFormField(
                                controller: repeatController,
                                inputType: TextInputType.text,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Repeat must not be empty";
                                  }
                                  return null;
                                },
                                widget: DropdownButton<dynamic>(
                                    style: context.bodyText1,
                                    enableFeedback: false,
                                    icon: Icon(IconBroken.Arrow___Down_2),
                                    underline: Container(),
                                    items: repeatItems
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text('$e'),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      repeatController.text = value;
                                    })),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Color", style: context.subtitle2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      isRed = true;
                                      isBlue = false;
                                      isOrange = false;
                                      isYellow = false;
                                    });
                                  }),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: isRed
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 25,
                                          )
                                        : null,
                                    backgroundColor: AppColors.redColor,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      isRed = false;
                                      isBlue = false;
                                      isOrange = false;
                                      isYellow = true;
                                    });
                                  }),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: isYellow
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 25,
                                          )
                                        : null,
                                    backgroundColor: AppColors.yelColor,
                                  ),
                                ),
                                // SizedBox(
                                //   width: 5,
                                // ),
                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      isRed = false;
                                      isBlue = true;
                                      isOrange = false;
                                      isYellow = false;
                                    });
                                  }),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: isBlue
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 25,
                                          )
                                        : null,
                                    backgroundColor: AppColors.blueColor,
                                  ),
                                ),

                                InkWell(
                                  onTap: (() {
                                    setState(() {
                                      isRed = false;
                                      isBlue = false;
                                      isOrange = true;
                                      isYellow = false;
                                    });
                                  }),
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: isOrange
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                            size: 25,
                                          )
                                        : null,
                                    backgroundColor: AppColors.orangeColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DefaultButton(
                                text: 'create task',
                                onpressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.insertToDatabase(
                                      title: titleController.text,
                                      date: dateController.text,
                                      startTime: startTimeController.text,
                                      endTime: endTimeController.text,
                                      color: isRed
                                          ? 'red'
                                          : isBlue
                                              ? 'blue'
                                              : isOrange
                                                  ? 'orange'
                                                  : 'yellow',
                                      remind: int.parse(remindController.text
                                          .split(' ')
                                          .first),
                                      repeat: repeatController.text,
                                      isCompleted: 0,
                                      isCompletedDate: '',
                                      isFavourit: 0,
                                    );
                                    Constants.pushReplace(
                                        context, ScheduleScreen());
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
