import 'package:flutter/material.dart';
import 'package:moodmap/screens/feedback_screen.dart';
import 'package:moodmap/screens/login_screen.dart';
import 'package:moodmap/screens/mood_evaluation_screen.dart';
import 'package:moodmap/screens/splash_screen.dart';

ThemeData appTheme = ThemeData(
  primaryColor: Colors.blue,
  fontFamily: 'Nunito',
);
void main() {
  runApp(MaterialApp(
    theme: appTheme,
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/moodCheck': (context) => MoodEvaluationScreen(),
      '/feedback': (context) => FeedbackScreen(),
    },
  ));
}
