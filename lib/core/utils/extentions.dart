import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';

extension ThemeExtentions on BuildContext {
  TextStyle? get subtitle1 => Theme.of(this).textTheme.subtitle1;
  TextStyle? get subtitle2 => Theme.of(this).textTheme.subtitle2;
  TextStyle? get bodyText1 => Theme.of(this).textTheme.bodyText1;
  TextStyle? get button => Theme.of(this).textTheme.button;
  TextStyle? get caption => Theme.of(this).textTheme.caption;
  Color get primaryColor => Theme.of(this).primaryColor;
}

extension BlocExtentions on BuildContext {
  AppCubit get cubit => BlocProvider.of<AppCubit>(this);
}
