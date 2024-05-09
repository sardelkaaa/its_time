import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:its_time/services/TaskServices.dart';
import 'package:intl/intl.dart';

//Класс с методами для выбора даты и времени при создании нового задания

class DateTimePickerScreen {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        dateController.text =
        "${selectedDate.day.toString().padLeft(2, '0')}.${
            selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}";
    }
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      timeController.text = selectedTime.format(context);
    }
  }

  void selectDateEdit(BuildContext context, String? taskId) async {
    var task = await TaskServices().getTaskById(taskId!);
    selectedDate = (task['date'] as Timestamp).toDate();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate = picked;
      dateController.text =
      "${selectedDate.day.toString().padLeft(2, '0')}.${
          selectedDate.month.toString().padLeft(2, '0')}.${selectedDate.year}";
      TaskServices().updateTaskDate(selectedDate, taskId);
    }
  }

  void selectTimeEdit(BuildContext context, String? taskId) async {
    var task = await TaskServices().getTaskById(taskId!);
    selectedTime = stringToTimeOfDay(task['time']);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      timeController.text = selectedTime.format(context);
      TaskServices().updateTaskTime(formatTime(selectedTime), taskId);
    }
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final format = DateFormat.Hm();
    try {
      final time = format.parse(timeString);
      return TimeOfDay(hour: time.hour, minute: time.minute);
    } catch (e) {
      throw ArgumentError('Invalid time format: $timeString');
    }
  }

  String formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  } // Преобразование формата времени в строку
}