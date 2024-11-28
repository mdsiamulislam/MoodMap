import 'package:flutter/material.dart';

import 'checkin_page.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Tracker"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Text(
            "Track Your Mood",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CheckInPage()),
                  );
                },
                child: Text("Start Check-In"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
