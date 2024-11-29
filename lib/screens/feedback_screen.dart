import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Your Feedback")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.emoji_emotions, size: 100, color: Colors.green),
            Text(
              "You’re feeling great! Keep it up!",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text("Take a 5-minute walk to stay focused."),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
