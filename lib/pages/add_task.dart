import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_time/services/DateTimePickerScreen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  DateTimePickerScreen dateTimePicker = DateTimePickerScreen();
  String titleInput = '';
  String descriptionInput = '';
  final ValueNotifier<int?> selectedPriority = ValueNotifier<int?>(null); // Переменные для ввода задания


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
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                    style: TextStyle(),
                    decoration: InputDecoration(
                      labelText: 'Название',
                      filled: true,
                      fillColor: Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String title) {
                      titleInput = title; // Изменение значения названия на вводимое пользователем
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                    controller: dateTimePicker.dateController,
                    decoration: InputDecoration(
                      labelText: 'Дата',
                      filled: true,
                      fillColor: Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today), //Иконка и выбор времени
                        color: Color(0xFFC6E9F3),
                        onPressed: () {
                          dateTimePicker.selectDate(context); // Вызов метода для выбора даты во всплывающем окне
                        },
                      ),
                    ),
                    onTap: () {
                      dateTimePicker.selectDate(context); // Вызов метода для выбора времени во всплывающем окне при нажатии на форму
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                    controller: dateTimePicker.timeController,
                    decoration: InputDecoration(
                      labelText: 'Время',
                      filled: true,
                      fillColor: Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.access_time), //Иконка и выбор времени
                        color: Color(0xFFC6E9F3),
                        onPressed: () {
                          dateTimePicker.selectTime(context); // Вызов метода для выбора времени во всплывающем окне
                        },
                      ),
                    ),
                    onTap: () {
                      dateTimePicker.selectTime(context); // Вызов метода для выбора времени во всплывающем окне при нажатии на форму
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Описание',
                      filled: true,
                      fillColor: Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    onChanged: (String description) {
                      descriptionInput = description; // Изменение значения описания на вводимое пользователем
                    },
                    minLines: 4,
                    maxLines: 4,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Добавляем отступ

                  Text(
                    'Приоритетность',
                    style: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Добавляем отступ

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 1; i <= 5; i++)
                        Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  selectedPriority.value = i;
                                });
                              },
                              child: Text('$i', style: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedPriority == i ? Colors.red : Color(0xFF1282A2),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
                                minimumSize: Size(MediaQuery.of(context).size.width * 0.15, MediaQuery.of(context).size.height * 0.05),
                                side: BorderSide(
                                  color: Color(0x80FFFFFF),
                                  width: 1.0,
                                )
                              ),
                            ),
                            Text(
                                i == 1 ? 'Min' : (i == 5 ? 'Max' : ''),
                                style: TextStyle(color: Color(0xFFC6E9F3), fontSize: 12,)
                            ),
                          ],
                        ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.035), // Добавляем отступ

                  ElevatedButton(
                    onPressed: () {
                      if (titleInput.isNotEmpty) {
                        // Add the task to Firebase
                        FirebaseFirestore.instance.collection('tasks').add({
                          'title': titleInput,
                          'description': descriptionInput,
                          'date': dateTimePicker.selectedDate,
                          'time': formatTime(dateTimePicker.selectedTime),
                          'priority': selectedPriority.value
                        });

                        Navigator.popAndPushNamed(context, '/'); // Возвращение на главную страницу после отправки задания

                      } else {
                        // Дисплей ошибки
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Пожалуйста, введите название задачи'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: Text('Добавить новое задание', style: TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1282A2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.8, MediaQuery.of(context).size.height * 0.08),
                      side: BorderSide(
                        color: Color(0x80FFFFFF),
                        width: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: BottomAppBar(
      //   shape: const CircularNotchedRectangle(),
      //   color: Color(0xFF1282A2),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: <Widget>[
      //       IconButton(
      //         icon: const Icon(Icons.history),
      //         iconSize: MediaQuery.of(context).size.width * 0.1, // Устанавляем размер иконки пропорционально ширине экрана
      //         color: Color(0xFFC6E9F3),
      //         onPressed: () {
      //           Navigator.pushNamed(context,
      //               '/history'); // Действия при нажатии на иконку истории
      //         },
      //       ),
      //       IconButton(
      //         icon: const Icon(Icons.settings),
      //         iconSize: MediaQuery.of(context).size.width * 0.1, // Устанавляем размер иконки пропорционально ширине экрана
      //         color: Color(0xFFC6E9F3),
      //         onPressed: () {
      //           Navigator.pushNamed(context,
      //               '/settings'); // Действия при нажатии на иконку настроек
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}