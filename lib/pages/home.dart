import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
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
                        bottom: phoneHeight * 0.02
                      ),
                      padding: EdgeInsets.only(
                        right: phoneWidth * 0.06075,
                        left: phoneWidth * 0.06075,
                        top: phoneHeight * 0.01728,
                        bottom: phoneWidth * 0.06075
                      ),
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
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: phoneHeight * 0.0108
                            ),
                            child: Container(
                              height: phoneHeight * 0.1432,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: phoneHeight * 0.00432,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          task['title'],
                                          style: TextStyle(
                                            fontSize: phoneHeight * 0.03,
                                            fontWeight: FontWeight.w600, //w700
                                            color: Color(0xFFC6E9F3),
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                    ),

                                    // Дата
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: phoneHeight * 0.00432,
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          isToday ? 'Сегодня в $taskTime'
                                              : '${DateFormat('EEEE, MMMM d, yyyy').format(taskDate)}'
                                              ' в $taskTime', // Форматированный вывод даты
                                          style: TextStyle(
                                            fontSize: phoneHeight * 0.023,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFFC6E9F3),
                                          ),
                                        ),
                                      ),
                                    ),

                                    task['description'].isEmpty ? Container() :
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Color(0xFF1282A2),
                                                title: Text(
                                                  'Описание задания',
                                                  style: TextStyle(
                                                    color: Color(0xFFC6E9F3),
                                                    fontWeight: FontWeight.w600
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                content: Text(
                                                  task['description'],
                                                  style: TextStyle(
                                                      color: Color(0xFFC6E9F3),
                                                      fontSize: phoneHeight * 0.01512,
                                                      fontWeight: FontWeight.w400
                                                  ),
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
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Открыть описание задания',
                                          style: TextStyle(
                                              color: Color(0xFFC6E9F3),
                                              fontSize: phoneHeight * 0.02,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // Кнопка изменения события
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: phoneWidth * 0.1,
                              height: phoneWidth * 0.1,
                              decoration: BoxDecoration(
                                color: Color(0x30000000),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                color: Color(0x90F3F3F3),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/editTask', arguments: task.id);
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  );
                } else {
                  return Center(
                    child: Container(
                      width: phoneWidth * 0.9182,
                      height: phoneHeight * 0.25,
                      margin: EdgeInsets.only(
                        bottom: phoneHeight * 0.02
                      ),
                      padding: EdgeInsets.only(
                        right: phoneWidth * 0.06075,
                        left: phoneWidth * 0.06075,
                        top: phoneHeight * 0.01728,
                        bottom: phoneWidth * 0.06075
                      ),
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
                            fontSize: phoneHeight * 0.023,
                            fontWeight: FontWeight.w500
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
                    height: phoneHeight * 0.474,
                    margin: EdgeInsets.only(
                        bottom: phoneHeight * 0.02
                    ),
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
                        var taskTime = data['time'];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: phoneWidth * 0.0187),
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
                                        fontSize: phoneHeight * 0.023,
                                        fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: EdgeInsets.only(right: phoneWidth * 0.0187),
                                  child: Container(
                                    width: phoneWidth * 0.08,
                                    height: phoneWidth * 0.08,
                                    decoration: BoxDecoration(
                                      color: Color(0x30000000),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        icon: Icon(Icons.edit, size: phoneWidth * 0.04,),
                                        color: Color(0x90F3F3F3),
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/editTask', arguments: documentId);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            data['description'].isEmpty ?
                            Padding(
                              padding: EdgeInsets.only(
                                top: phoneHeight * 0.00864
                              ),
                              child: Container(),
                            ) :
                            Padding(
                              padding: EdgeInsets.only(
                                left: phoneWidth * 0.089,
                                right: phoneWidth * 0.089,
                                bottom: phoneHeight * 0.00864,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Color(0xFF1282A2),
                                          title: Text(
                                            'Описание задания',
                                            style: TextStyle(
                                              color: Color(0xFFC6E9F3)
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          content: Text(
                                            data['description'],
                                            style: TextStyle(
                                                color: Color(0xFFC6E9F3),
                                                fontSize: phoneHeight * 0.01512,
                                            ),
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
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'Открыть описание задания',
                                    style: TextStyle(
                                        color: Color(0xFFC6E9F3),
                                        fontSize: phoneHeight * 0.017,
                                        fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ),
                              ),
                            ),



                            Padding(
                              padding: EdgeInsets.only(
                                left: phoneWidth * 0.0187,
                                right: phoneWidth * 0.0187,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      '$taskTime', // Форматированный вывод даты
                                      style: TextStyle(
                                          color: Color(0xFFC6E9F3),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),

                                  Text(
                                      '${DateFormat('dd.MM.yyyy').format(taskDate)}', // Форматированный вывод даты
                                      style: TextStyle(
                                          color: Color(0xFFC6E9F3),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500
                                      )
                                  ),

                                ],
                              ),
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
                  height: phoneHeight * 0.474,
                  margin: EdgeInsets.only(
                      bottom: phoneHeight * 0.02
                  ),
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
                        fontSize: phoneHeight * 0.023,
                        fontWeight: FontWeight.w500
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
          size: phoneWidth * 0.1, // Вычисляем размер иконки как 10% ширины экрана
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