import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:its_time/pages/home.dart';
import 'package:its_time/pages/authorization.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Пользователь авторизован, проверяем, подтвержден ли его email
          if (snapshot.data!.emailVerified) {
            return Home();
          } else {
            // Email не подтвержден, показываем страницу авторизации
            return Authorization();
          }
        } else {
          // Пользователь не авторизован, показываем страницу авторизации
          return Authorization();
        }
      },
    );
  }
}