import 'package:flutter/material.dart';
import 'package:moodmap/const/color.dart';
import 'package:moodmap/screens/MoodSelector.dart';
import '../const/consValu.dart';
import '../models/MoodBarChart.dart';
import 'package:url_launcher/url_launcher.dart';  // For opening URLs (YouTube links)

class MoodEvaluationScreen extends StatefulWidget {
  @override
  _MoodEvaluationScreenState createState() => _MoodEvaluationScreenState();
}

class _MoodEvaluationScreenState extends State<MoodEvaluationScreen> {
  int currentPageIndex = 0;

  // Function to launch YouTube video
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/home');
                break;
              case 1:
                Navigator.pushNamed(context, '/statistics');
                break;
              case 2:
                Navigator.pushNamed(context, '/diary');
                break;
            }
          });
        },
        indicatorColor: primaryBtn,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            selectedIcon: Icon(Icons.show_chart_outlined),
            label: 'Statistics',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Diary',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Award',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mood Bar Chart Section
                SizedBox(
                  height: 300,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MoodBarChart(
                        moodLevels: moodList, // Use your data source here
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Self-improvement Tips Section
                Text(
                  "Tips for Self-Improvement",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryBtn,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Here are some tips to improve your mood",
                  style: TextStyle(fontSize: 13, color: primaryBtn),
                ),
                const SizedBox(height: 16),
                Column(
                  children: [
                    ListTile(
                      title: Text("1. Get enough sleep"),
                      subtitle: Text("Sleep is important for your mood and overall health"),
                    ),
                    ListTile(
                      title: Text("2. Exercise regularly"),
                      subtitle: Text("Exercise can help you feel better and improve your mood"),
                    ),
                    ListTile(
                      title: Text("3. Eat a healthy diet"),
                      subtitle: Text("Eating a healthy diet can improve your mood and energy levels"),
                    ),
                    ListTile(
                      title: Text("4. Practice mindfulness"),
                      subtitle: Text("Mindfulness can help reduce stress and improve your mood"),
                    ),
                    ListTile(
                      title: Text("5. Spend time with loved ones"),
                      subtitle: Text("Spending time with loved ones can improve your mood and mental health"),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Video Section
                Text(
                  "Recommended Videos",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Watch these videos for more tips based on your situation",
                  style: TextStyle(fontSize: 13, color: Colors.green.shade700),
                ),
                const SizedBox(height: 16),

                // Video Suggestions
                GestureDetector(
                  onTap: () {
                    _launchURL('https://www.youtube.com/watch?v=video1');
                  },
                  child: ListTile(
                    title: Text("How to Improve Mood with Sleep"),
                    subtitle: Text("Learn tips to improve sleep quality"),
                    leading: Icon(Icons.video_library),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://www.youtube.com/watch?v=video2');
                  },
                  child: ListTile(
                    title: Text("Exercise for a Better Mood"),
                    subtitle: Text("Learn how exercise affects mood"),
                    leading: Icon(Icons.video_library),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://www.youtube.com/watch?v=video3');
                  },
                  child: ListTile(
                    title: Text("Mindfulness for Stress Relief"),
                    subtitle: Text("Learn how mindfulness reduces stress"),
                    leading: Icon(Icons.video_library),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _launchURL('https://www.youtube.com/watch?v=video4');
                  },
                  child: ListTile(
                    title: Text("Eat Healthy to Boost Your Mood"),
                    subtitle: Text("Learn how healthy eating improves mood"),
                    leading: Icon(Icons.video_library),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MoodSelector()));
        },
        backgroundColor: primaryBtn,
        child: Icon(Icons.emoji_emotions),
      ),
    );
  }
}
