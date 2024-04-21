import 'package:flutter/material.dart';
import 'package:its_time/pages/add_task.dart';
import 'package:its_time/pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
    '/todo': (context) => AddTask(),
  },
));
