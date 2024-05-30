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
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы

      appBar: AppBar(
        backgroundColor: Color(0xFF0A1128), // Цвет фона шапки
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: MediaQuery.of(context).size.height * 0.04,
          color: Color(0xFFC6E9F3),
          onPressed: () {
            Navigator.pop(context); // Вернуться на главную страницу
          },
        ), // Кнопка вернуться на главный экран

        title: Center(
          child: Text('Уведомления',
            style: TextStyle(
                color: Color(0xFFC6E9F3),
                fontSize: MediaQuery.of(context).size.height * 0.02268,
                fontWeight: FontWeight.w500
            ),
          ),
        ),

        actions: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.1)
        ],
      ),

      body: Column(
        children: [
          Container(
            width:MediaQuery.of(context).size.height * 0.82,
            height: MediaQuery.of(context).size.height * 0.82, // Уменьшаем высоту контейнера
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0108,
            ),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.0216,
                bottom: MediaQuery.of(context).size.height * 0.0216,
                right: MediaQuery.of(context).size.width * 0.035,
                left: MediaQuery.of(context).size.width * 0.035
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
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.087, // Уменьшаем высоту контейнера
                        margin: const EdgeInsets.all(10.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF1282A2),
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                            color: Color(0x80FFFFFF),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.027,
                              right: MediaQuery.of(context).size.width * 0.027,
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height * 0.0108,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        'Название задания',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.height * 0.0173,
                                          color: Color(0xFFC6E9F3),
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'время',
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.height * 0.0173,
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
                                        fontSize: MediaQuery.of(context).size.height * 0.013,
                                        color: Color(0xFFC6E9F3),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'дата',
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.height * 0.013,
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
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),

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
