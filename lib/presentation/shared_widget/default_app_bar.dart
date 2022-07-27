// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:todo/config/styles/icon_broken.dart';
import 'package:todo/core/utils/extentions.dart';
import 'package:todo/presentation/shared_widget/default_divider.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({Key? key, required this.text, this.onPressedArrow})
      : super(key: key);
  final String text;
  final VoidCallback? onPressedArrow;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              MaterialButton(
                  padding: EdgeInsets.zero,
                  minWidth: 1,
                  onPressed: onPressedArrow,
                  child: Icon(
                    IconBroken.Arrow___Left_2,
                    size: 22,
                  )),
              SizedBox(
                width: 17,
              ),
              Text(text, style: context.subtitle1),
            ],
          ),
        ),
        DefaultDivider(),
      ],
    );
  }
}
