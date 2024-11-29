import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/mood_provider.dart';

class MoodSummaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mood = Provider.of<MoodProvider>(context).currentMood;

    if (mood == null) {
      return Text("No mood selected yet.");
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Current Mood",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  mood.emoji,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(width: 10),
                Text(
                  mood.label,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Energy Level: ${mood.energyLevel}"),
            Text("Stressed: ${mood.stressed ? "Yes" : "No"}"),
          ],
        ),
      ),
    );
  }
}
