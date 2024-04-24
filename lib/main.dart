import 'package:flutter/material.dart';
import 'package:its_time/pages/DateTimePickerScreen.dart';
import 'package:its_time/pages/add_task.dart';
import 'package:its_time/pages/notifications.dart';
import 'package:its_time/pages/history.dart';
import 'package:its_time/pages/profile.dart';
import 'package:its_time/pages/settings.dart';
import 'package:its_time/pages/all_tasks.dart';
import 'package:its_time/pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/addTask': (context) => AddTask(),
    '/allTasks': (context) => AllTasks(),
    '/history': (context) => History(),
    '/notifications': (context) => Notifications(),
    '/profile': (context) => Profile(),
    '/settings': (context) => Settings(),
  },
));
