import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo/presentation/notifications/notifications_screen.dart';

import '../models/task.dart';

class NotifiyHelper {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final BehaviorSubject<String> selectNotificationSubject =
      BehaviorSubject<String>();

  String selectedNotificationPayload = '';

  static initNotifications() async {
    tz.initializeTimeZones();
    _configureSelectNotificationSubject();
    await _configureLocalTimeZone();
    // await requestIOSPermissions(flutterLocalNotificationsPlugin);
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notask');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload!);
      },
    );
  }

  static Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  // static void selectNotification(
  //   String? payload,
  // ) async {
  //   if (payload != null) {
  //     debugPrint('notification payload: $payload');
  //   }
  //   await Get.to(() => NotificationsScreen(payload: 'payload1|pay2|pay3'));
  // }

  static displayNotifications(
      {required String title, required String body}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    IOSNotificationDetails iosNotificationDetails =
        const IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'item x');
  }

  static scheduleNotifications(int hour, int minutes, Task task) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        task.id!,
        'ToDo',
        task.remind == 0
            ? '${task.title} is now'
            : task.remind == 5
                ? '${task.title} is after 5 minutes'
                : task.remind == 10
                    ? '${task.title} is after 10 minutes'
                    : task.remind == 15
                        ? '${task.title} is after 15 minutes'
                        : '${task.title} is after 20 minutes',
        _nextInstanceOfTenAM(
            hour, minutes, task.remind!, task.repeat!, task.date!),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'reminder|${task.title}|${task.startTime}|');
  }

  static tz.TZDateTime _nextInstanceOfTenAM(
      int hour, int minutes, int remind, String repeat, String date) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    var formatedDate = DateFormat('yyyy-MM-dd').parse(date);
    final tz.TZDateTime localFormatedDate =
        tz.TZDateTime.from(formatedDate, tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        localFormatedDate.year,
        localFormatedDate.month,
        localFormatedDate.day,
        hour,
        minutes);

    scheduledDate = afterRemind(remind, scheduledDate);
    print('scheduledDate $scheduledDate');
    if (scheduledDate.isBefore(now)) {
      if (repeat == 'Daily') {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formatedDate.day) + 1, hour, minutes);
      } else if (repeat == "Weekly") {
        scheduledDate = tz.TZDateTime(tz.local, now.year, now.month,
            (formatedDate.day) + 7, hour, minutes);
      } else if (repeat == "Monthly") {
        scheduledDate = tz.TZDateTime(tz.local, now.year,
            (formatedDate.month) + 1, formatedDate.day, hour, minutes);
      }
      scheduledDate = afterRemind(remind, scheduledDate);
      print('scheduledDate $scheduledDate');
    }
    return scheduledDate;
  }

  static tz.TZDateTime afterRemind(int remind, tz.TZDateTime scheduledDate) {
    if (remind == 5) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 5));
    } else if (remind == 10) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 10));
    } else if (remind == 15) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 15));
    } else if (remind == 20) {
      scheduledDate = scheduledDate.subtract(const Duration(minutes: 20));
    }
    return scheduledDate;
  }

  static cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(CupertinoAlertDialog(
      title: Text(title!),
      content: Text(body!),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () async {
            Get.back();
            await Get.to(NotificationsScreen(payload: payload!));
          },
        )
      ],
    ));
  }

  static void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      debugPrint('My payload is ' + payload);
      await Get.to(() => NotificationsScreen(payload: payload));
    });
  }
}
