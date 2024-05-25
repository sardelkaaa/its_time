import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  BucketListSettings createState() => BucketListSettings();
}

class BucketListSettings extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы

      appBar: AppBar(
        backgroundColor: Color(0xFF0A1128), // Цвет фона шапки
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: MediaQuery.of(context).size.width * 0.1,
          color: Color(0xFFC6E9F3),
          onPressed: () {
            Navigator.pop(context); // Вернуться на главную страницу
          },
        ), // Кнопка вернуться на главный экран

        title: Center(
          child: Text('Настройки',
            style: TextStyle(
                color: Color(0xFFC6E9F3),
                fontSize: 21,
                fontWeight: FontWeight.w500
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: MediaQuery.of(context).size.width * 0.1,
            color: Color(0xFFC6E9F3),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // Действие при нажатии на значок уведомлений
            },
          ), // Кнопка уведомлений
        ],
      ),

      body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.82, // Уменьшаем высоту контейнера
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1282A2), Color(0xFF034078)],
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),

              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.56,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Row(
                          children: [
                            Icon(Icons.translate, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFC6E9F3)),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Text(
                              'Сменить язык',
                              style: TextStyle(
                                color: Color(0xFFC6E9F3),
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.55,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Row(
                          children: [
                            Icon(Icons.color_lens, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFC6E9F3)),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Text(
                              'Сменить тему',
                              style: TextStyle(
                                color: Color(0xFFC6E9F3),
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Row(
                          children: [
                            Icon(Icons.question_answer, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFC6E9F3)),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Text(
                              'FAQ',
                              style: TextStyle(
                                color: Color(0xFFC6E9F3),
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.72,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Row(
                          children: [
                            Icon(Icons.support_agent, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFC6E9F3)),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Text(
                              'Служба поддержки',
                              style: TextStyle(
                                color: Color(0xFFC6E9F3),
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil('/authorization', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.055,
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFFF8C00)),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                            Text(
                              'Выйти из аккаунта',
                              style: TextStyle(
                                color: Color(0xFFFF8C00),
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
    );
  }
}