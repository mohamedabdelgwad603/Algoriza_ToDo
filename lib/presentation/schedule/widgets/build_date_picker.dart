import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: DatePicker(
        DateTime.now(),
        height: 85,
        width: 60,
        onDateChange: (date) {
          BlocProvider.of<AppCubit>(context).getselectedDate(date);
        },
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: Colors.teal,
        dateTextStyle: TextStyle(
            fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
        dayTextStyle: TextStyle(
            fontSize: 18, color: Colors.grey, fontWeight: FontWeight.w500),
        monthTextStyle: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
