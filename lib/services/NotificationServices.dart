
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationServices extends ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings
    );
  }

  Future<void> scheduleNotificationOneHourBeforeTask(
      DateTime taskDate, TimeOfDay taskTime, String title, String taskId, String? taskDescription) async {
    tz.initializeTimeZones();
    var taskDateTime =
    DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);
    if (taskDateTime.isAfter(DateTime.now())) {
      var scheduledDate = tz.TZDateTime.from(
          taskDateTime.subtract(const Duration(hours: 1)), tz.local);
      var notificationDate = DateFormat('dd.MM.yyyy HH:mm').format(scheduledDate);
      if (scheduledDate.isAfter(DateTime.now())) {
        AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'your channel id',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          styleInformation: BigTextStyleInformation('Ваша задача начнется через час\n'
              '$taskDescription'), // Correct usage
        );
        NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
        await flutterLocalNotificationsPlugin.zonedSchedule(
          taskId.hashCode + 1,
          title,
          notificationDate,
          scheduledDate,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }

  Future<void> scheduleNotificationAfterDeadline(
      DateTime taskDate, TimeOfDay taskTime, String title, String taskId, String? taskDescription) async {
    tz.initializeTimeZones();
    var taskDateTime =
    DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);
    if (taskDateTime.isAfter(DateTime.now())) {
      var scheduledDate =  tz.TZDateTime.from(taskDateTime, tz.local);
      var notificationDate = DateFormat('dd.MM.yyyy HH:mm').format(scheduledDate);
      AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: BigTextStyleInformation('Пришло время выполнить задание!\n'
            '$taskDescription'),
      );
      NotificationDetails notificationDetails =
      NotificationDetails(android: androidNotificationDetails);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        taskId.hashCode,
        title,
        notificationDate,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  Future<void> cancelScheduledNotification(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
    await flutterLocalNotificationsPlugin.cancel(notificationId + 1);
  }

  Future<List<ActiveNotification>> getActiveNotifications() async {
    final List<ActiveNotification> activeNotifications =
    await flutterLocalNotificationsPlugin.getActiveNotifications();
    return activeNotifications;
  }
}