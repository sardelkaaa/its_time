import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:its_time/services/NotificationServices.dart';

class TaskServices extends ChangeNotifier{

  final CollectionReference<Map<String, dynamic>> tasks = FirebaseFirestore.instance
      .collection('tasks');

  Future<DocumentSnapshot<Map<String, dynamic>>> getTaskById(String taskId) {
    return tasks.doc(taskId).get();
  }

  Stream<QuerySnapshot> getTasks() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Stream<QuerySnapshot>.empty();
    }

    return tasks.where('userId', isEqualTo: user.uid)
        .orderBy('date')
        .orderBy('priority', descending: true)
        .snapshots();
  }


  bool isToday(DateTime taskDate) {
    var currentDate = DateTime.now();
    return currentDate.year == taskDate.year &&
        currentDate.month == taskDate.month && currentDate.day == taskDate.day;
  }

  Future<void> updateTaskTitle(String newTitle, String? taskId) async {
    tasks.doc(taskId).update({
      'title': newTitle,
    }).then((_) {
      print('Успешно обновлено в Firestore');
    }).catchError((error) {
      print('Ошибка при обновлении в Firestore: $error');
    });
  }

  Future<void> updateTaskDescription(String newDescription, String? taskId) async {
    tasks.doc(taskId).update({
      'description': newDescription,
    }).then((_) {
      print('Успешно обновлено в Firestore');
    }).catchError((error) {
      print('Ошибка при обновлении в Firestore: $error');
    });
  }

  Future<void> updateTaskDate(DateTime newDate, String? taskId) async {
    await tasks.doc(taskId).update({
      'date': newDate,
    }).then((_) {
      print('Успешно обновлено в Firestore');
    }).catchError((error) {
      print('Ошибка при обновлении в Firestore: $error');
    });
  }

  Future<void> updateTaskTime(String? newTime, String? taskId) async {
    await tasks.doc(taskId).update({
      'time': newTime,
    }).then((_) {
      print('Успешно обновлено в Firestore');
    }).catchError((error) {
      print('Ошибка при обновлении в Firestore: $error');
    });
  }

  Future<void> deleteTask(String taskId, BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF1282A2),
          title: Text(
              'Удалить задачу?',
            style: TextStyle(
              color: Color(0xFFC6E9F3),
              fontSize: MediaQuery.of(context).size.height * 0.023,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
              'Вы уверены, что хотите удалить эту задачу?',
            style: TextStyle(
              color: Color(0xFFC6E9F3),
              fontSize: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                      'Отмена',
                    style: TextStyle(
                      color: Color(0x50000000),
                      fontSize: MediaQuery.of(context).size.height * 0.023,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    NotificationServices().cancelScheduledNotification(taskId.hashCode);
                    tasks.doc(taskId).delete();
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Удалить',
                    style: TextStyle(
                      color: Color(0xFFC6E9F3),
                      fontSize: MediaQuery.of(context).size.height * 0.023,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> updateTask(int? newPriority, String? taskId) async {
    tasks.doc(taskId).update({
      'priority': newPriority,
    }).then((_) {
      print('Успешно обновлено в Firestore');
    }).catchError((error) {
      print('Ошибка при обновлении в Firestore: $error');
    });
  }
}