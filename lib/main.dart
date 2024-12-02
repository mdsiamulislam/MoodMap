import 'package:flutter/material.dart';
import 'package:moodmap/screens/award.dart';
import 'package:moodmap/screens/diary/diary_home_page.dart';
import 'package:moodmap/screens/login_screen.dart';
import 'package:moodmap/screens/mood_evaluation_screen.dart';
import 'package:moodmap/screens/splash_screen.dart';
import 'package:moodmap/screens/statistics/statistics_home_page.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.green,
      fontFamily: 'nunito',
    ),
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/moodCheck': (context) => MoodEvaluationScreen(),
      '/diary': (context) => DiaryHomePage(),
      '/statistics': (context) => StatisticsHomePage(),
      '/award': (context) => Award(),


    },
    debugShowCheckedModeBanner: false,
  ));
}