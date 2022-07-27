// ignore_for_file: prefer_if_null_operators

import 'package:flutter/material.dart';
import 'package:todo/core/utils/extentions.dart';

import '../../../config/styles/outline_input_border_style.dart';
import '../../../core/utils/app_colors.dart';

class DefaultFormField extends StatelessWidget {
  const DefaultFormField(
      {Key? key,
      this.hint,
      this.widget,
      this.validate,
      this.onChange,
      this.controller,
      required this.inputType})
      : super(key: key);
  final String? hint;

  final TextEditingController? controller;

  final TextInputType inputType;
  final Widget? widget;
  final String? Function(String?)? validate;
  final void Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        onChanged: onChange,
        validator: validate,
        style: context.caption?.copyWith(fontSize: 18),
        cursorColor: Colors.grey[400],
        decoration: InputDecoration(
          hintStyle:
              context.caption?.copyWith(fontSize: 18, color: Colors.grey[200]),
          border: AppBorderStyles.OutlineInputBorderStyle(),
          focusedBorder: AppBorderStyles.OutlineInputBorderStyle(),
          //enabledBorder: InputBorder.none,
          errorBorder: AppBorderStyles.OutlineInputBorderStyle(),

          filled: true,
          fillColor: Colors.grey[50],
          hintText: hint,
          suffixIcon: widget,
        ),
      ),
    );
  }
}
