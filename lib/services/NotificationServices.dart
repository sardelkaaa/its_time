import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:its_time/services/TaskServices.dart';
import 'dart:math';
import 'package:its_time/services/DateTimePickerScreen.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  final TaskServices _taskServices = TaskServices();

  Future initializeNotifications() async {
    // Инициализация локальных уведомлений
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Подписываемся на изменения в списке задач
    _taskServices.getTasks().listen((snapshot) {
      // Проверяем, есть ли новые задачи
      for (var task in snapshot.docs) {
        // Получаем данные о задаче
        var taskDate = (task['date'] as Timestamp).toDate();
        var taskTime = DateTimePickerScreen().stringToTimeOfDay(task['time']);
        String taskId = task.id;

        // Отправляем уведомления в зависимости от даты и времени
        scheduleNotification(taskId, taskDate, taskTime, task['title']);
      }
    });

    // Подписываемся на удаление задач
    _taskServices.getTasks().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.removed) {
          // Отправляем уведомление об удалении задачи
          showNotification(change.doc.id, 'Задача удалена', '');
        }
      }
    });
  }

  void scheduleNotification(
      String taskId, DateTime taskDate, TimeOfDay taskTime, String title) {
    // Создаем объект DateTime с учетом времени задачи
    DateTime taskDateTime = DateTime(taskDate.year, taskDate.month, taskDate.day,
        taskTime.hour, taskTime.minute);

    // Вычисляем время до задачи
    Duration timeToTask = taskDateTime.difference(DateTime.now());

    // Определяем, нужно ли отправлять уведомление
    if (timeToTask.inHours < 1 && timeToTask.inMinutes > 0) {
      // Уведомление за час до задачи
      showNotification(taskId, 'Задача наступит через $timeToTask', title);
    } else if (taskDateTime.isBefore(DateTime.now())) {
      // Уведомление о просроченной задаче
      showNotification(taskId, 'Срок задания подошёл к концу', title);
    }
  }

  Future showNotification(String taskId, String title, String body) async {
    // Формируем текст уведомления
    String notificationBody = '$title\n$body';

    // Создаем уникальный ID для уведомления
    int notificationId = Random().nextInt(1000000);

    // Отображаем локальное уведомление
    await _flutterLocalNotificationsPlugin.show(
      notificationId,
      title,
      notificationBody,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
        ),
      ),
    );
  }
}