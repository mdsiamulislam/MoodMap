import 'package:flutter/material.dart';
import '../models/mood_model.dart';

class MoodProvider with ChangeNotifier {
  Mood? _currentMood;
  List<Mood> _moodHistory = [];

  Mood? get currentMood => _currentMood;
  List<Mood> get moodHistory => _moodHistory;

  void updateMood(Mood mood) {
    _currentMood = mood;
    _moodHistory.add(mood);
    notifyListeners();
  }

  void clearMoodHistory() {
    _moodHistory.clear();
    notifyListeners();
  }
}