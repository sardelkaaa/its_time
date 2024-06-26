import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:its_time/pages/authorization.dart';
import 'package:its_time/pages/editTask.dart';
import 'package:its_time/pages/registration.dart';
import 'package:its_time/services/FirebaseService.dart';
import 'package:its_time/pages/add_task.dart';
import 'package:its_time/pages/notifications.dart';
import 'package:its_time/pages/history.dart';
import 'package:its_time/pages/settings.dart';
import 'package:its_time/pages/home.dart';
import 'package:its_time/services/AuthorizationWrapper.dart';
import 'package:its_time/pages/reset_password.dart';
import 'package:its_time/services/NotificationServices.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseService().initializeFirebase();
  NotificationServices notificationServices = NotificationServices();
  await notificationServices.initializeNotifications();

  runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ru'),
    ],
    home: AuthenticationWrapper(),
    // Если пользователь уже авторизован - переходим на страницу home,
    routes: {
      '/addTask': (context) => const AddTask(),
      '/home': (context) => const Home(),
      '/authorization': (context) => const Authorization(),
      '/history': (context) => const History(),
      '/notifications': (context) => const Notifications(),
      '/settings': (context) => const Settings(),
      '/editTask': (context) => const EditTask(),
      '/registration': (content) => const Registration(),
      '/resetPassword': (content) => const ResetPassword(),
    },
  ));
}

