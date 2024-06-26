import 'package:flutter/material.dart';
import 'package:its_time/services/DateTimePickerScreen.dart';
import 'package:its_time/services/NotificationServices.dart';
import 'package:its_time/services/TaskServices.dart';
import 'package:intl/intl.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key});

  @override
  State<EditTask> createState() => EditTaskState();
}

class EditTaskState extends State<EditTask> {

  DateTimePickerScreen dateTimePicker = DateTimePickerScreen();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValueNotifier<int?> selectedPriority = ValueNotifier(null);
  String? taskId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Получить идентификатор задания из аргументов маршрута
    taskId = (ModalRoute.of(context)?.settings.arguments as String?)!;

    // Загрузить данные задания из firestore
    TaskServices().getTaskById(taskId!).then((task) {
      // Заполнить текстовые поля данными задания
      if (task.exists) {
        titleController.text = task['title'];
        dateTimePicker.dateController.text = DateFormat('dd.MM.yyyy').format(task['date'].toDate());
        dateTimePicker.timeController.text = task['time'];
        descriptionController.text = task['description'];
        selectedPriority.value = task['priority'];
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFF0A1128), // Цвет фона страницы

      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1128), // Цвет фона шапки
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          iconSize: MediaQuery.of(context).size.width * 0.1,
          color: const Color(0xFFC6E9F3),
          onPressed: () {
            Navigator.pop(context); // Вернуться на главную страницу
          },
        ), // Кнопка вернуться на главный экран

        title: Center(
          child: Text('Редактировать задание', // Добавляем текст "Новое задание" в качестве заголовка
            style: TextStyle(
                color: const Color(0xFFC6E9F3),
                fontSize: phoneHeight * 0.027,
                fontWeight: FontWeight.w500
            ),
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: MediaQuery.of(context).size.width * 0.1,
            color: const Color(0xFFC6E9F3),
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
                    controller: titleController, // Привязка контроллера к текстовому полю
                    style: const TextStyle(
                      color: Color(0xFFC6E9F3),
                      decoration: TextDecoration.none,
                      decorationColor: Color(0x01C6E9F3),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Название',
                      filled: true,
                      fillColor: const Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    cursorColor: const Color(0xFFC6E9F3),
                    cursorWidth: 1,
                    onChanged: (newTitle) {
                      TaskServices().updateTaskTitle(newTitle, taskId);
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                      controller: dateTimePicker.dateController, // Привязка контроллера к текстовому полю
                      style: const TextStyle(
                      color: Color(0xFFC6E9F3),
                      decoration: TextDecoration.none,
                      decorationColor: Color(0x01C6E9F3),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Дата',
                      filled: true,
                      fillColor: const Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_today), //Иконка и выбор времени
                        color: const Color(0xFFC6E9F3),
                        onPressed: ()  async {
                          dateTimePicker.selectDateEdit(context, taskId);
                        },
                      ),
                    ),
                    cursorColor: const Color(0xFFC6E9F3),
                    cursorWidth: 1,
                    onTap: () async {
                        dateTimePicker.selectDateEdit(context, taskId);
                      },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                    controller: dateTimePicker.timeController, // Привязка контроллера к текстовому полю
                    style: const TextStyle(
                      color: Color(0xFFC6E9F3),
                      decoration: TextDecoration.none,
                      decorationColor: Color(0x01C6E9F3),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Время',
                      filled: true,
                      fillColor: const Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.access_time), //Иконка и выбор времени
                        color: const Color(0xFFC6E9F3),
                        onPressed: () async {
                          dateTimePicker.selectTimeEdit(context, taskId);
                        },
                      ),
                    ),
                    cursorColor: const Color(0xFFC6E9F3),
                    cursorWidth: 1,
                    onTap: () async {
                      dateTimePicker.selectTimeEdit(context, taskId);
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  TextFormField(
                    controller: descriptionController, // Привязка контроллера к текстовому полю
                    style: const TextStyle(
                      color: Color(0xFFC6E9F3),
                      decoration: TextDecoration.none,
                      decorationColor: Color(0x01C6E9F3),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Описание',
                      filled: true,
                      fillColor: const Color(0xFF1282A2), // Цвет фона
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0), // Закругление углов
                        borderSide: const BorderSide(color: Color(0x80FFFFFF)), // Цвет границы
                      ),
                      labelStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      hintStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                      errorStyle: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    cursorColor: const Color(0xFFC6E9F3),
                    cursorWidth: 1,
                    minLines: 4,
                    maxLines: 4,
                    onChanged: (newDescription) {
                      TaskServices().updateTaskDescription(newDescription, taskId);
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Добавляем отступ

                  const Text(
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
                                  selectedPriority.value = i; // Установить значение выбранного приоритета
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedPriority.value == i ? const Color(0xFF0F6B83) : const Color(0xFF1282A2), // Установить цвет фона в зависимости от значения selectedPriority
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                                  minimumSize: Size(MediaQuery.of(context).size.width * 0.15, MediaQuery.of(context).size.height * 0.05),
                                  side: const BorderSide(
                                    color: Color(0x80FFFFFF),
                                    width: 1.0,
                                  )
                              ),
                              child: Text('$i', style: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                            Text(
                                i == 1 ? 'Min' : (i == 5 ? 'Max' : ''),
                                style: const TextStyle(color: Color(0xFFC6E9F3), fontSize: 12,)
                            ),
                          ],
                        ),
                    ],
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.035), // Добавляем отступ

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: MediaQuery.of(context).size.width * 0.125,
                        color: const Color(0xFFC04768),
                        //Color(0xFFC6E9F3),
                        onPressed: () {
                          TaskServices().deleteTask(taskId!, context);
                        },
                      ),

                      IconButton(
                        icon: const Icon(Icons.check),
                        iconSize: MediaQuery.of(context).size.width * 0.125,
                        color: const Color(0xFFC6E9F3),
                        onPressed: () {
                          NotificationServices().cancelScheduledNotification(taskId.hashCode);
                          NotificationServices().cancelScheduledNotification(taskId.hashCode + 1);
                          TaskServices().updateTask(selectedPriority.value, taskId).then((_) {
                            NotificationServices().scheduleNotificationOneHourBeforeTask(
                                dateTimePicker.selectedDate,
                                dateTimePicker.selectedTime,
                                titleController.text,
                                taskId!, descriptionController.text
                            );
                            NotificationServices().scheduleNotificationAfterDeadline(
                                dateTimePicker.selectedDate,
                                dateTimePicker.selectedTime,
                                titleController.text,
                                taskId!, descriptionController.text
                            );
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
