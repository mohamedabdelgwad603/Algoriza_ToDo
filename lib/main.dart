// ignore_for_file: prefer_const_constructors

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/config/themes/app_theme.dart';
import 'package:todo/network/local/cashe_helper.dart';
import 'package:todo/presentation/notifications/notifications_screen.dart';
import 'package:todo/presentation/splash_screen/default_splash_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/observer.dart';
import 'cubit/states.dart';
import 'presentation/board/screens/board_layout_screen.dart';
import 'sevices/notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotifiyHelper.initNotifications();

  await CashHelper.init();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..createDataBase()
        ..getIsDarkFromSharedPred(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = BlocProvider.of<AppCubit>(context);
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Themes.lightTheme,
              darkTheme: Themes.darkTheme,
              themeMode: cubit.themeMode,
              home: DefaultSplashScreen(),
            );
          }),
    );
  }
}
