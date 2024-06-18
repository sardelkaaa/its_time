import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  BucketListHistory createState() => BucketListHistory();
}

class BucketListHistory extends State<History> {

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
          child: Text('История',
            style: TextStyle(
                color: const Color(0xFFC6E9F3),
                fontSize: phoneHeight * 0.03,
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
            width: phoneWidth * 1,
            height: phoneHeight * 0.82, // Уменьшаем высоту контейнера
            margin: EdgeInsets.only(
              top: phoneHeight * 0.0108,
            ),
            padding: EdgeInsets.only(
              top: phoneHeight * 0.03,
              bottom: phoneHeight * 0.027,
              left: phoneWidth * 0.0584,
              right: phoneWidth * 0.0584,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1282A2), Color(0xFF034078)],
              ),
              borderRadius: BorderRadius.circular(25.0),
            ),

            child: Center(
              child: Text(
                'Нет завершённых заданий',
                style: TextStyle(
                    fontSize: phoneHeight * 0.023,
                    color: const Color(0xFFC6E9F3),
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}