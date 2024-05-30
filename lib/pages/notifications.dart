import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  BucketListNotifications createState() => BucketListNotifications();
}

class BucketListNotifications extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var phoneWidth = MediaQuery.of(context).size.width;
    var phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы

      appBar: AppBar(
        backgroundColor: Color(0xFF0A1128), // Цвет фона шапки
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: phoneHeight * 0.04,
          color: Color(0xFFC6E9F3),
          onPressed: () {
            Navigator.pop(context); // Вернуться на главную страницу
          },
        ), // Кнопка вернуться на главный экран

        title: Center(
          child: Text('Уведомления',
            style: TextStyle(
                color: Color(0xFFC6E9F3),
                fontSize: phoneHeight * 0.02268,
                fontWeight: FontWeight.w500
            ),
          ),
        ),

        actions: [
          SizedBox(width: phoneWidth * 0.1)
        ],
      ),

      body: Column(
        children: [
          Container(
            width:phoneHeight * 0.82,
            height: phoneHeight * 0.82, // Уменьшаем высоту контейнера
            margin: EdgeInsets.only(
                top: phoneHeight * 0.0108,
            ),
            padding: EdgeInsets.only(
                right: phoneWidth * 0.07,
                left: phoneWidth * 0.07
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1282A2), Color(0xFF034078)],
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),

            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: phoneHeight * 0.04,
                        bottom: phoneHeight * 0.027,
                      ),
                      child: Container(
                        height: phoneHeight * 0.087, // Уменьшаем высоту контейнера
                        decoration: BoxDecoration(
                          color: Color(0xFF1282A2),
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                            color: Color(0x80FFFFFF),
                          ),
                        ),
                        padding: EdgeInsets.only(
                          top: phoneHeight * 0.0108,
                          bottom: phoneHeight * 0.0108,
                          left: phoneWidth * 0.0584,
                          right: phoneWidth * 0.0584,
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: phoneHeight * 0.0108,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text(
                                      'Название задания',
                                      style: TextStyle(fontSize: phoneHeight * 0.0173, color: Color(0xFFC6E9F3), fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'время',
                                      style: TextStyle(
                                          fontSize: phoneHeight * 0.0173,
                                          color: Color(0xFFC6E9F3),
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Text(
                                    'Описание задания',
                                    style: TextStyle(
                                      fontSize: phoneHeight * 0.013,
                                      color: Color(0xFFC6E9F3),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'дата',
                                    style: TextStyle(
                                      fontSize: phoneHeight * 0.013,
                                      color: Color(0xFFC6E9F3),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
