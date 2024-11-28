import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData greenTheme = ThemeData(
    primaryColor: Colors.green,
    hintColor: Colors.greenAccent,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
    ),
  );
}
