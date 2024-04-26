import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:its_time/pages/DateTimePickerScreen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DateTimePickerScreen dateTimePicker = DateTimePickerScreen();
  String titleInput = '';
  String descriptionInput = ''; // Переменные для ввода задания


  @override
  void initState() {
    super.initState();
  } // Инициализирование статичности

  String formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  } // Преобразование формата времени в строку

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
            Navigator.pushNamed(context, '/'); // Вернуться на главную страницу
          },
        ), // Кнопка вернуться на главный экран

        title: Center(
            child: Text('Новое задание', // Добавляем текст "Новое задание" в качестве заголовка
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

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.73, // Уменьшаем высоту контейнера
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
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Название',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String title) {
                      titleInput = title; // Изменение значения названия на вводимое пользователем
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dateTimePicker.dateController,
                    decoration: InputDecoration(
                      labelText: 'Дата',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today), //Иконка и выбор времени
                        onPressed: () {
                          dateTimePicker.selectDate(context); // Вызов метода для выбора даты во всплывающем окне
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dateTimePicker.timeController,
                    decoration: InputDecoration(
                      labelText: 'Время',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time), //Иконка и выбор времени
                        onPressed: () {
                          dateTimePicker.selectTime(context); // Вызов метода для выбора времени во всплывающем окне
                        },
                      ),
                    ),
                    onTap: () {
                      dateTimePicker.selectTime(context); // Вызов метода для выбора времени во всплывающем окне при нажатии на форму
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Описание',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String description) {
                      descriptionInput = description; // Изменение значения описания на вводимое пользователем
                    },
                  ),
                  const SizedBox(height: 230), // Добавляем отступ

                  ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance.collection('tasks').add({
                        'title': titleInput,
                        'description': descriptionInput,
                        'date': dateTimePicker.selectedDate,
                        'time': formatTime(dateTimePicker.selectedTime)
                      }); // Добавление задания в Firebase

                      Navigator.popAndPushNamed(context, '/'); // Выход после отправления задания в Firebase
                    },
                    child: const Text('Отправить'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1282A2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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