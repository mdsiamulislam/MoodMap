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
  bool isMoodSubmitted = false; // Track if the mood is submitted

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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[100]!, Colors.white!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
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
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MoodBarChart(
                            moodLevels: moodList, // Use your data source here
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // // Mood Evaluation Section
                  // Visibility(
                  //   visible: !isMoodSubmitted,
                  //   child: InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         isMoodSubmitted = true;
                  //       });
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => MoodSelector()));
                  //     },
                  //     child: Container(
                  //       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  //       decoration: BoxDecoration(
                  //         color: Colors.green[500],
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           Text(
                  //             "Today's Mood Evaluation",
                  //             style: TextStyle(
                  //               fontSize: 24,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //           const SizedBox(width: 24),
                  //           Icon(Icons.alarm, color: Colors.white),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(height: 8),

                  // Self-improvement Tips Section
                  Text(
                    "Tips for Self-Improvement",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Here are some tips to improve your mood",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      ListTile(
                        title: Text("1. Get enough sleep"),
                        subtitle: Text("Sleep is important for your mood and overall health", ),
                      ),
                      ListTile(
                        title: Text("2. Exercise regularly"),
                        subtitle: Text("Exercise can help you feel better and improve your mood", ),
                      ),
                      ListTile(
                        title: Text("3. Eat a healthy diet",),
                        subtitle: Text("Eating a healthy diet can improve your mood and energy levels", ),
                      ),
                      ListTile(
                        title: Text("4. Practice mindfulness",),
                        subtitle: Text("Mindfulness can help reduce stress and improve your mood", ),
                      ),
                      ListTile(
                        title: Text("5. Spend time with loved ones",),
                        subtitle: Text("Spending time with loved ones can improve your mood and mental health",),
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
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Watch these videos for more tips based on your situation",
                    style: TextStyle(fontSize: 13, ),
                  ),
                  const SizedBox(height: 16),

                  // Video Suggestions
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://www.youtube.com/watch?v=video1');
                    },
                    child: ListTile(
                      title: Text("How to Improve Mood with Sleep",),
                      subtitle: Text("Learn tips to improve sleep quality",),
                      leading: Icon(Icons.video_library, ),
                      trailing: Icon(Icons.arrow_forward, ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://www.youtube.com/watch?v=video2');
                    },
                    child: ListTile(
                      title: Text("Exercise for a Better Mood",),
                      subtitle: Text("Learn how exercise affects mood",),
                      leading: Icon(Icons.video_library, ),
                      trailing: Icon(Icons.arrow_forward, ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://www.youtube.com/watch?v=video3');
                    },
                    child: ListTile(
                      title: Text("Mindfulness for Stress Relief", ),
                      subtitle: Text("Learn how mindfulness reduces stress",),
                      leading: Icon(Icons.video_library,),
                      trailing: Icon(Icons.arrow_forward,),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL('https://www.youtube.com/watch?v=video4');
                    },
                    child: ListTile(
                      title: Text("Eat Healthy to Boost Your Mood", ),
                      subtitle: Text("Learn how healthy eating improves mood", ),
                      leading: Icon(Icons.video_library, ),
                      trailing: Icon(Icons.arrow_forward, ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
              case 3:
                Navigator.pushNamed(context, '/award');
                break;
            }
          });
        },
        backgroundColor: Colors.green.shade200,
        indicatorColor: Colors.green.shade500,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isMoodSubmitted = true;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => MoodSelector()));
        },
        backgroundColor: primaryBtn,
        child: Icon(Icons.emoji_emotions),
      ),
    );
  }
}