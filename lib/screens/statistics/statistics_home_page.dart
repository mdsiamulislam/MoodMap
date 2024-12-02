import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsHomePage extends StatefulWidget {
  const StatisticsHomePage({super.key});

  @override
  State<StatisticsHomePage> createState() => _StatisticsHomePageState();
}

class _StatisticsHomePageState extends State<StatisticsHomePage> {
  int currentPageIndex = 1;
  Map<String, List<String>> groupedMoodLogs = {};

  @override
  void initState() {
    super.initState();
    _loadMoodLogs();
  }

  Future<void> _loadMoodLogs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> moodLogs = prefs.getStringList('moodLogs') ?? [];
    Map<String, List<String>> tempGroupedMoodLogs = {};

    for (var log in moodLogs) {
      List<String> logParts = log.split(' - ');
      if (logParts.length < 3) continue; // Skip invalid logs
      String dateTime = logParts.last.split(' ').sublist(0, 4).join(' ');
      if (tempGroupedMoodLogs.containsKey(dateTime)) {
        tempGroupedMoodLogs[dateTime]!.add(log);
      } else {
        tempGroupedMoodLogs[dateTime] = [log];
      }
    }

    // Sort the logs so that the latest logs appear at the top
    tempGroupedMoodLogs = Map.fromEntries(
      tempGroupedMoodLogs.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );

    setState(() {
      groupedMoodLogs = tempGroupedMoodLogs;
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
            const SizedBox(height: 10),
            Expanded(
              child: groupedMoodLogs.isNotEmpty
                  ? ListView.builder(
                itemCount: groupedMoodLogs.keys.length,
                itemBuilder: (context, index) {
                  String dateTime = groupedMoodLogs.keys.elementAt(index);
                  List<String> logs = groupedMoodLogs[dateTime]!;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateTime,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ...logs.map((log) {
                            List<String> logParts = log.split(' - ');
                            String mood = logParts[0];
                            String description = logParts[1];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: mood,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' - $description',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
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