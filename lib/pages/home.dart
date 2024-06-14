import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:its_time/services/TaskServices.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  BucketListHomePage createState() => BucketListHomePage();
}

class BucketListHomePage extends State<Home> {

  @override
  Widget build(BuildContext context) {
    var phoneHeight = MediaQuery.of(context).size.height;
    var phoneWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF0A1128), // Цвет фона страницы

      appBar: AppBar(
        backgroundColor: Color(0xFF0A1128), // Цвет фона шапки
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: phoneWidth * 0.1,
            color: Color(0xFFC6E9F3),// Устанавляем размер иконки пропорционально ширине экрана
            onPressed: () {
              Navigator.pushNamed(context, '/notifications'); // Действие при нажатии на значок уведомлений
            },
          ),
        ],
      ),

      body:
      Column(
        children: [
          StreamBuilder(
              stream: TaskServices().getTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  var task = snapshot.data!.docs.first; // Получаем первое задание из списка
                  var taskDate = (task['date'] as Timestamp).toDate();
                  var taskTime = task['time']; // Значения даты и времени первого задания
                  var isToday = TaskServices().isToday(taskDate);
                  return Center(
                    child: Container(
                      width: phoneWidth * 0.9182,
                      height: phoneHeight * 0.25,
                      margin: EdgeInsets.only(
                        bottom: phoneHeight * 0.027
                      ),
                      padding: EdgeInsets.all(phoneHeight * 0.0173),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1282A2), Color(0xFF034078)],
                        ),
                        borderRadius: BorderRadius.circular(35.0),
                        color: Colors.grey[200],
                      ),

                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: phoneHeight * 0.0108,
                              ),
                              child: Text(
                                task['title'],
                                style: TextStyle(
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold, //w700
                                  color: Color(0xFFC6E9F3),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        
                            // Дата
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: phoneHeight * 0.0108,
                              ),
                              child: Text(
                                isToday ? 'Сегодня в $taskTime'
                                    : '${DateFormat('EEEE, MMMM d, yyyy').format(taskDate)}'
                                    ' в $taskTime', // Форматированный вывод даты
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFC6E9F3),
                                ),
                                  textAlign: TextAlign.center
                              ),
                            ),
                        
                            // Описание
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: phoneHeight * 0.0108,
                              ),
                              child: Text(
                                task['description'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFC6E9F3),
                                ),
                                textAlign: TextAlign.center
                              ),
                            ),
                        
                            // Кнопка изменения события
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: phoneWidth * 0.1,
                                height: phoneWidth * 0.1,
                                decoration: BoxDecoration(
                                  color: Color(0xFF1282A2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.edit),
                                  color: Color(0xFFC6E9F3),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/editTask', arguments: task.id);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                        width: phoneWidth * 0.9182,
                        height: phoneHeight * 0.25,
                        padding: EdgeInsets.all(phoneHeight * 0.0173),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF1282A2), Color(0xFF034078)],
                          ),
                          borderRadius: BorderRadius.circular(35.0),
                          color: Colors.grey[200],
                        ),
                      child: Center(
                        child: Text(
                          'Нет текущего основного задания',
                          style: TextStyle(
                            color: Color(0xFFC6E9F3),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }
          ),


          StreamBuilder<QuerySnapshot>(
            stream: TaskServices().getTasks(), // Обращение к вспомогательному методу для вывода заданий из БД
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.hasData && snapshot.data!.docs.skip(1).isNotEmpty) {
                return Center(
                  child: Container(
                    width: phoneWidth * 0.9182,
                    height: phoneHeight * 0.48,
                    padding: EdgeInsets.all(phoneHeight * 0.0173),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF1282A2), Color(0xFF034078)]
                      ),
                    ),
                    child: ListView(
                      children: snapshot.data!.docs.skip(1).map((DocumentSnapshot document) {
                        Map data = document.data() as Map;
                        var documentId = document.id;
                        var taskDate = (data['date'] as Timestamp).toDate(); // Значения даты заданий
                        return Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(phoneWidth * 0.0187),
                                  child: Container(
                                    width: phoneWidth * 0.05,
                                    height: phoneWidth * 0.05,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [Color(0xFFFFC700), Color(0xFFFF4F00)]
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      color: Color(0xFFFF8C00),
                                      size: phoneWidth * 0.035,
                                    ),
                                  ),
                                ),

                                Container(
                                  width: phoneWidth * 0.64,
                                  child: Text(
                                    data['title'],
                                    style: TextStyle(
                                        color: Color(0xFFC6E9F3),
                                        fontSize: phoneWidth * 0.042,
                                        fontWeight: FontWeight.w500
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),

                                Spacer(),

                                Container(
                                  width: phoneWidth * 0.08,
                                  height: phoneWidth * 0.08,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF1282A2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                      icon: Icon(Icons.edit, size: phoneWidth * 0.04,),
                                      color: Color(0xFFC6E9F3),
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/editTask', arguments: documentId);
                                        },
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Align(
                              alignment: Alignment(-0.8, 1.0),
                              child: Text(
                                  '${DateFormat('dd.MM.yyyy').format(taskDate)}', // Форматированный вывод даты
                                  style: TextStyle(
                                      color: Color(0xFFC6E9F3),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500)),
                            ),

                            const Divider(
                              color: Color(0xFFCBC9C5),
                              thickness: 1,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              } else {
                return Container(
                  width: phoneWidth * 0.9182,
                  height: phoneHeight * 0.46,
                  padding: EdgeInsets.all(phoneHeight * 0.0173),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35.0),
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1282A2), Color(0xFF034078)]
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Нет текущих заданий',
                      style: TextStyle(
                        color: Color(0xFFC6E9F3),
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addTask');
        },
        backgroundColor: Color(0xFF1282A2),
        child: Icon(
          Icons.add,
          size: phoneWidth * 0.12, // Вычисляем размер иконки как 10% ширины экрана
          color: Color(0xFFC6E9F3),
        ),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Color(0xFF1282A2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.history),
                iconSize: phoneWidth * 0.1, // Устанавляем размер иконки пропорционально ширине экрана
                color: Color(0xFFC6E9F3),
                onPressed: () {
                  Navigator.pushNamed(context, '/history'); // Действия при нажатии на иконку истории
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                iconSize: phoneWidth * 0.1, // Устанавляем размер иконки пропорционально ширине экрана
                color: Color(0xFFC6E9F3),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings'); // Действия при нажатии на иконку настроек
                },
              ),
            ],
          ),
        ),
    );
  } 
}