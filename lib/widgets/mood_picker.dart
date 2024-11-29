import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';
import '../models/mood_model.dart';

class MoodPicker extends StatefulWidget {
  @override
  _MoodPickerState createState() => _MoodPickerState();
}

class _MoodPickerState extends State<MoodPicker> {
  final List<Map<String, String>> _moods = [
    {'emoji': '😊', 'label': 'Happy'},
    {'emoji': '😟', 'label': 'Anxious'},
    {'emoji': '😢', 'label': 'Sad'},
    {'emoji': '😤', 'label': 'Angry'},
    {'emoji': '🤩', 'label': 'Excited'},
  ];

  String? _selectedMood;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _moods.map((mood) {
          final isSelected = _selectedMood == mood['emoji'];
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedMood = mood['emoji'];
                Provider.of<MoodProvider>(context, listen: false).updateMood(
                  Mood(
                    emoji: mood['emoji']!,
                    label: mood['label']!,
                    energyLevel: 3,
                    stressed: false,
                    emotions: [],
                  ),
                );
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: isSelected
                    ? Border.all(color: Colors.green, width: 2)
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    mood['emoji']!,
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 4),
                  Text(
                    mood['label']!,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
