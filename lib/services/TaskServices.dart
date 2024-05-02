import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class TaskServices {

  var tasks = FirebaseFirestore.instance
      .collection('tasks')
      .orderBy('date')
      .orderBy('priority',
      descending: true) // Пропустить запись с идентификатором документа documentId
      .snapshots();

  Stream<QuerySnapshot> getTasks() {
    return tasks;
  }

  bool isToday(DateTime taskDate) {
    var currentDate = DateTime.now();
    return currentDate.year == taskDate.year &&
        currentDate.month == taskDate.month && currentDate.day == taskDate.day;
  }
}