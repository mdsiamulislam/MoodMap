import 'package:flutter/material.dart';
import 'package:moodmap/screens/diary/diary_home_page.dart';
import 'package:moodmap/screens/login_screen.dart';
import 'package:moodmap/screens/mood_evaluation_screen.dart';
import 'package:moodmap/screens/splash_screen.dart';
import 'package:moodmap/screens/statistics/statistics_home_page.dart';

// Define a custom color palette for better organization and maintainability
const Color darkBackgroundColor = Color.fromRGBO(11, 24, 33, 1);
const Color primaryTextColor = Colors.white; // Adjust this for better contrast
Color? secondaryTextColor = Colors.grey[500]; // Optional secondary color

ThemeData appTheme = ThemeData(
  primaryColor: darkBackgroundColor, // Use the darkBackgroundColor for primary
  fontFamily: 'Nunito',
  brightness: Brightness.dark, // Ensure dark theme for consistent background
  textTheme: TextTheme(
    // Set text colors for different text styles
    displayLarge: const TextStyle(fontSize: 30, color: primaryTextColor),
    displayMedium: const TextStyle(fontSize: 24, color: primaryTextColor),
    bodyLarge: const TextStyle(fontSize: 16, color: primaryTextColor),
    bodyMedium: TextStyle(fontSize: 14, color: secondaryTextColor),
    // ... other text styles as needed
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: darkBackgroundColor, // Set app bar background color
    foregroundColor: primaryTextColor,   // Set app bar text color
  ),
  // ... other theme properties as needed (e.g., button colors, etc.)
);

void main() {
  runApp(MaterialApp(
    theme: appTheme,
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/login': (context) => LoginScreen(),
      '/moodCheck': (context) => MoodEvaluationScreen(),
      '/diary': (context) => DiaryHomePage(),
      '/statistics': (context) => StatisticsHomePage(),

    },
  ));
}