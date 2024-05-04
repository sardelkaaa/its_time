import 'package:flutter/material.dart';

//Класс с методами для выбора даты и времени при создании нового задания

class DateTimePickerScreen {
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      // locale: const Locale("ru", "RU"), //Русификация календаря выбора даты
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
        selectedDate = picked;
        dateController.text =
        "${selectedDate.day}.${selectedDate.month}.${selectedDate.year}";
    };
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
}