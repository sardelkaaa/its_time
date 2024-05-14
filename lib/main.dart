import 'package:flutter/material.dart';
import 'package:its_time/pages/authorization.dart';
import 'package:its_time/pages/editTask.dart';
import 'package:its_time/pages/registration.dart';
import 'package:its_time/services/FIrebaseService.dart';
import 'package:its_time/pages/add_task.dart';
import 'package:its_time/pages/notifications.dart';
import 'package:its_time/pages/history.dart';
import 'package:its_time/pages/profile.dart';
import 'package:its_time/pages/settings.dart';
import 'package:its_time/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService().initializeFirebase();

  User? user = FirebaseAuth.instance.currentUser;

  runApp(MaterialApp(
    initialRoute: (user != null) ? '/home' : '/',
    // Если пользователь уже авторизован - переходим на страницу home,
    routes: {
      '/': (context) => Authorization(),
      '/addTask': (context) => AddTask(),
      '/home': (context) => Home(),
      '/history': (context) => History(),
      '/notifications': (context) => Notifications(),
      '/profile': (context) => Profile(),
      '/settings': (context) => Settings(),
      '/editTask': (context) => EditTask(),
      '/registration': (content) => Registration(),
    },
  ));
}

