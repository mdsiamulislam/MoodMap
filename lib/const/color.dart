import 'package:flutter/material.dart';
//
// const Color primaryBGColor = Color.fromRGBO(11, 24, 33, 1);
const Color primaryBGColor = Colors.white;
const Color accentColor = Color(0xFF9C27B0);
const Color primaryBtn = Color.fromRGBO(34, 197, 94, 1);


// Define the gradient colors
const Color topColor = Colors.green; // Light yellow-green
const Color bottomColor = Colors.white; // Dark purple-blue

// Create the gradient
final LinearGradient moodSelectorGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [topColor, bottomColor],
);