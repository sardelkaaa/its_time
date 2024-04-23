import 'package:flutter/material.dart';
class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы
      appBar: AppBar(
        backgroundColor: Color(0xFF0A1128), // Цвет фона шапки
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: MediaQuery.of(context).size.width * 0.1,// Устанавляем размер иконки пропорционально ширине экрана
            color: Color(0xFFC6E9F3),
            onPressed: () {
              Navigator.pushNamed(context,
                  '/notifications'); // Действие при нажатии на значок уведомлений
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.735,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1282A2), Color(0xFF034078)],
              ),
              borderRadius: BorderRadius.circular(35.0),
              color: Colors.grey[200],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Color(0xFF1282A2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.history),
              iconSize: MediaQuery.of(context).size.width * 0.1, // Устанавляем размер иконки пропорционально ширине экрана
              color: Color(0xFFC6E9F3),
              onPressed: () {
                Navigator.pushNamed(context,
                    '/history'); // Действия при нажатии на иконку истории
              },
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              iconSize: MediaQuery.of(context).size.width * 0.1, // Устанавляем размер иконки пропорционально ширине экрана
              color: Color(0xFFC6E9F3),
              onPressed: () {
                Navigator.pushNamed(context,
                    '/settings'); // Действия при нажатии на иконку настроек
              },
            ),
          ],
        ),
      ),
    );
  }
}