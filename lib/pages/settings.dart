import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  BucketListSettings createState() => BucketListSettings();
}

class BucketListSettings extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
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
                fontSize: phoneHeight * 0.03,
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
              width: phoneWidth * 1,
              height: phoneHeight * 0.82, // Уменьшаем высоту контейнера
              padding: EdgeInsets.all(
                phoneWidth * 0.075
              ),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: phoneHeight * 0.025
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: AlertDialog(
                                  backgroundColor: Color(0xFF1282A2),
                                  content: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: phoneWidth * 0.02,
                                        ),
                                        child: Text(
                                          'Ответы на возможные вопросы:',
                                          style: TextStyle(
                                              color: Color(0xFFC6E9F3),
                                              fontSize: phoneHeight * 0.02,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: phoneWidth * 0.01,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '1) Как связаться с поддержкой?',
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.017,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: phoneWidth * 0.02,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '- Написать на эл.почту its.time@outlook.com',
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.017,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: phoneWidth * 0.01,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '2) Как открыть название задания полностью, если оно показывается не полностью?',
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.017,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: phoneWidth * 0.02,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '- Нажать на название задания и оно полностью покажется во всплывающем окне',
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.017,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: phoneWidth * 0.01,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '3) Как работает приоритетность заданий?',
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.017,
                                                fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                          bottom: phoneWidth * 0.02,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '- В зависимости от выбранного уровня приоритетности, задание выставляется по важности в списке текущих заданий',
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.017,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Закрыть',
                                        style: TextStyle(
                                          color: Color(0xFFC6E9F3),
                                          fontSize: phoneHeight * 0.02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Row(
                            children: [
                              Icon(Icons.question_answer, size: phoneHeight * 0.06, color: Color(0xFFC6E9F3)),
                              SizedBox(width: phoneWidth * 0.02),
                              Text(
                                'FAQ',
                                style: TextStyle(
                                  color: Color(0xFFC6E9F3),
                                  fontSize: phoneHeight * 0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                        bottom: phoneHeight * 0.025
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: AlertDialog(
                                  backgroundColor: Color(0xFF1282A2),
                                  content: Column(
                                    children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            bottom: phoneWidth * 0.02,
                                          ),
                                          child: Text(
                                          'Электронная почта для связи:',
                                          style: TextStyle(
                                            color: Color(0xFFC6E9F3),
                                            fontSize: phoneHeight * 0.02,
                                            fontWeight: FontWeight.w600
                                          ),
                                                                              ),
                                        ),

                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                          'its.time@outlook.com',
                                          style: TextStyle(
                                            color: Color(0xFFC6E9F3),
                                            fontSize: phoneHeight * 0.017,
                                            fontWeight: FontWeight.w400
                                          ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Закрыть',
                                        style: TextStyle(
                                          color: Color(0xFFC6E9F3),
                                          fontSize: phoneHeight * 0.02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.745,
                          child: Row(
                            children: [
                              Icon(Icons.support_agent, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFC6E9F3)),
                              SizedBox(width: phoneWidth * 0.02),
                              Text(
                                'Связь с поддержкой',
                                style: TextStyle(
                                  color: Color(0xFFC6E9F3),
                                  fontSize: phoneHeight * 0.025,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushNamedAndRemoveUntil('/authorization', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Icon(Icons.exit_to_app, size: MediaQuery.of(context).size.height * 0.06, color: Color(0xFFFF8C00)),
                            SizedBox(width: phoneWidth * 0.02),
                            Text(
                              'Выйти из аккаунта',
                              style: TextStyle(
                                color: Color(0xFFFF8C00),
                                fontSize: phoneHeight * 0.025,
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