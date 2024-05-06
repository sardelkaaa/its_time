import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:its_time/services/DateTimePickerScreen.dart';



class TaskServices {

  final CollectionReference<Map<String, dynamic>> tasks = FirebaseFirestore.instance
      .collection('tasks');

  Future<DocumentSnapshot<Map<String, dynamic>>> getTaskById(String taskId) {
    return tasks.doc(taskId).get();
  }

  Stream<QuerySnapshot> getTasks() {
    return tasks.orderBy('date')
        .orderBy('priority',
        descending: true)
        .snapshots();;
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

  Future<void> deleteTask(String? taskId) async {
    await tasks.doc(taskId).delete();
  }
}