import 'package:flutter/material.dart';

class SnackBarService {
  static const errorColor = Colors.red;
  static const okColor = Colors.green;

  static Future<void> showErrorSnackBar(
      BuildContext context, String message, bool error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: error ? errorColor : okColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future<void> showSuccessfulSnackBar(
      BuildContext context, String message, bool error) async {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}