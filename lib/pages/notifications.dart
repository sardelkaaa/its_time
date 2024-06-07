import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:its_time/services/NotificationServices.dart';
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  BucketListNotifications createState() => BucketListNotifications();
}

class BucketListNotifications extends State<Notifications> {
  final notificationServices = NotificationServices();
  late Future<List<ActiveNotification>> activeNotifications;

  @override
  void initState() {
    super.initState();
    // Получение активных уведомлений при создании виджета
    activeNotifications = notificationServices.getActiveNotifications();
  }

  @override
  Widget build(BuildContext context) {
    var phoneWidth = MediaQuery.of(context).size.width;
    var phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF0A1128), // Цвет фона страницы

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1128), // Цвет фона шапки
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: phoneHeight * 0.04,
          color: const Color(0xFFC6E9F3),
          onPressed: () {
            Navigator.pop(context); // Вернуться на главную страницу
          },
        ), // Кнопка вернуться на главный экран

        title: Center(
          child: Text('Уведомления',
            style: TextStyle(
                color: const Color(0xFFC6E9F3),
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
            width: phoneHeight * 0.82,
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

            child: FutureBuilder<List<ActiveNotification>>(
              future: activeNotifications,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ActiveNotification> notifications = snapshot.data!;
                  if (notifications.isEmpty) {
                    return Center(
                      child: Text(
                        'Нет активных уведомлений',
                        style: TextStyle(
                            fontSize: phoneHeight * 0.0173,
                            color: const Color(0xFFC6E9F3),
                            fontWeight: FontWeight.w600),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        ActiveNotification notification = notifications[index];
                        var notificationDate = DateFormat('dd.MM.yyyy').format(
                          DateFormat('dd.MM.yyyy HH:mm').parse(notification.body!));
                        var notificationTime = DateFormat('HH:mm').format(
                            DateFormat('dd.MM.yyyy HH:mm').parse(notification.body!));
                        return Container(
                          margin: EdgeInsets.only(
                            top: phoneHeight * 0.04,
                            bottom: phoneHeight * 0.027,
                            left: phoneWidth * 0.0584,
                            right: phoneWidth * 0.0584,
                          ),
                          child: Container(
                            height: phoneHeight * 0.087, // Уменьшаем высоту контейнера
                            decoration: BoxDecoration(
                              color: const Color(0xFF1282A2),
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(
                                color: const Color(0x80FFFFFF),
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
                                      Expanded(
                                        child: Text(
                                          notification.title ?? 'Название задания',
                                          style: TextStyle(fontSize: phoneHeight * 0.0173, color: const Color(0xFFC6E9F3), fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        notificationTime,
                                        style: TextStyle(
                                            fontSize: phoneHeight * 0.0173,
                                            color: const Color(0xFFC6E9F3),
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notification.bigText ?? 'Описание задания',
                                        style: TextStyle(
                                          fontSize: phoneHeight * 0.013,
                                          color: const Color(0xFFC6E9F3),
                                          fontWeight: FontWeight.w600,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      notificationDate,
                                      style: TextStyle(
                                        fontSize: phoneHeight * 0.013,
                                        color: const Color(0xFFC6E9F3),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Ошибка при получении уведомлений',
                      style: TextStyle(
                          fontSize: phoneHeight * 0.0173,
                          color: const Color(0xFFC6E9F3),
                          fontWeight: FontWeight.w600),
                    ),
                  );
                } else { // snapshot.waiting
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFFC6E9F3),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}