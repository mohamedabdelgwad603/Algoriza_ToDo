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
        style: context.bodyText1,
        cursorColor: context.primaryColor,
        decoration: InputDecoration(
          hintStyle: context.caption?.copyWith(fontSize: 16),
          enabledBorder: OutlineInputBorder(
              // ignore: prefer_const_constructors
              borderSide: BorderSide(
                width: 1,
                color: context.primaryColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          border: OutlineInputBorder(
              // ignore: prefer_const_constructors
              borderSide: BorderSide(
                width: 1,
                color: context.primaryColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
              // ignore: prefer_const_constructors
              borderSide: BorderSide(
                width: 1,
                color: context.primaryColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          //enabledBorder: InputBorder.none,
          errorBorder: OutlineInputBorder(
              // ignore: prefer_const_constructors
              borderSide: BorderSide(
                width: 1,
                color: context.primaryColor,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(8.0)),

          filled: true,
          fillColor: context.cubit.themeMode == ThemeMode.dark
              ? Colors.black
              : Colors.white,
          hintText: hint,
          suffixIcon: widget,
        ),
      ),
    );
  }
}
