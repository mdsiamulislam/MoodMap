import 'package:flutter/material.dart';

import '../widgets/mood_picker.dart';

class MoodEvaluationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mood Check-In")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How are you feeling right now?",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            MoodPicker(), // Custom widget for emoji selection
            SizedBox(height: 20),
            Slider(
              value: 3,
              min: 1,
              max: 5,
              divisions: 4,
              label: "3",
              onChanged: (value) {},
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/feedback'),
              child: Text("Submit My Mood"),
            ),
          ],
        ),
      ),
    );
  }
}
