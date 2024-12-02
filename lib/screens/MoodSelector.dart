import 'package:flutter/material.dart';
import 'package:moodmap/mood_sug.dart';

class MoodSelector extends StatefulWidget {
  @override
  _MoodSelectorState createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  // Keep track of selected emotions
  final Set<String> _selectedEmotions = {};

  // Define your emotion categories
  final List<String> yellowEmotions = [
    "Aroused", "Cheeky", "Free", "Joyful", "Curious", "Inquisitive",
    "Successful", "Confident", "Respected", "Valued", "Courageous",
    "Creative", "Loving", "Thankful", "Sensitive", "Intimate",
    "Hopeful", "Inspired"
  ];

  final List<String> purpleEmotions = ["Fragile", "Grief", "Empty", "Embarrassed", "Ashamed"];

  @override
  Widget build(BuildContext context) {
    // A helper function to create emotion buttons
    List<Widget> buildEmotionButtons(List<String> emotions) {
      return emotions.map((emotion) {
        final isSelected = _selectedEmotions.contains(emotion);
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (isSelected) {
                  _selectedEmotions.remove(emotion); // Deselect
                } else {
                  _selectedEmotions.add(emotion); // Select
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: isSelected ? Colors.green[100] : Colors.white,
                borderRadius: BorderRadius.circular(18.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                emotion,
                style: TextStyle(
                  color: isSelected ? Colors.green[800] : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Selector'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How are you feeling right now?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "Happy Emotions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow[800]),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: buildEmotionButtons(yellowEmotions),
            ),
            SizedBox(height: 16),
            Text(
              "Sad Emotions",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue[300]),
            ),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: buildEmotionButtons(purpleEmotions),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission of selected emotions
                  print("Selected Emotions: $_selectedEmotions");
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> MoodSug( selectedEmotion: _selectedEmotions.toList())));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  "Submit My Mood",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}