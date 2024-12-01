import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsHomePage extends StatefulWidget {
  const StatisticsHomePage({super.key});

  @override
  State<StatisticsHomePage> createState() => _StatisticsHomePageState();
}

class _StatisticsHomePageState extends State<StatisticsHomePage> {
  int currentPageIndex = 1;
  List<String> groupedMoodLogs = [];

  @override
  void initState() {
    super.initState();
    _loadMoodLogs();
  }

  // Load grouped mood logs saved by MoodSug class
  Future<void> _loadMoodLogs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      groupedMoodLogs = prefs.getStringList('groupedMoodLogs') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Statistics'),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/moodCheck');
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
        indicatorColor: Colors.green,
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            const Text(
              'Mood Logs & Statistics',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display grouped mood logs
            const Text(
              'Your Mood Check Logs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: groupedMoodLogs.isNotEmpty
                  ? ListView.builder(
                itemCount: groupedMoodLogs.length,
                itemBuilder: (context, index) {
                  final moodLog = groupedMoodLogs[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        moodLog,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              )
                  : const Center(
                child: Text(
                  'No mood logs saved yet.',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
