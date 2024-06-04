import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices extends ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Map<String, int> notificationIdMap = {};

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotificationOneHourBeforeTask(DateTime taskDate, TimeOfDay taskTime, String title, String taskId) async {
    tz.initializeTimeZones();
    var taskDateTime = DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);
    if (taskDateTime.isAfter(DateTime.now())) {
      var scheduledDate = tz.TZDateTime.from(
          taskDateTime.subtract(const Duration(hours: 1)), tz.local);
      if (scheduledDate.isAfter(DateTime.now())) {
        int notificationId = taskId.hashCode;
        notificationIdMap[taskId] = notificationId;

        const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
        const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          'Уведомление за час до задания',
          'Ваша задача "$title" начнется через час',
          scheduledDate,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }

  Future<void> scheduleNotificationAfterDeadline(DateTime taskDate, TimeOfDay taskTime, String title, String taskId) async {
    tz.initializeTimeZones();
    var taskDateTime = DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);
    if (taskDateTime.isAfter(DateTime.now())) {
      var scheduledDate = tz.TZDateTime.from(taskDateTime, tz.local);
      int notificationId = taskId.hashCode;
      notificationIdMap[taskId] = notificationId;

      const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
          'channel id',
          'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker'

      );
      const NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        'Уведомление в установленное время',
        'Срок выполнения Вашего задания "$title" подошёл к концу',
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelNotification(String taskId) async {
    int? notificationId = notificationIdMap[taskId];
    if (notificationId != null) {
      await flutterLocalNotificationsPlugin.cancel(notificationId);
      notificationIdMap.remove(taskId);
    }
  }
}