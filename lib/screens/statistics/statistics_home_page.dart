import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsHomePage extends StatefulWidget {
  const StatisticsHomePage({super.key});

  @override
  State<StatisticsHomePage> createState() => _StatisticsHomePageState();
}

class _StatisticsHomePageState extends State<StatisticsHomePage> {
  int currentPageIndex = 1;
  double moodRating = 5.0;  // Default rating (out of 10)
  TextEditingController _noteController = TextEditingController();
  List<String> savedStatistics = [];

  @override
  void initState() {
    super.initState();
    _loadStatistics();
  }

  // Load previous evaluations from SharedPreferences
  _loadStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      savedStatistics = prefs.getStringList('savedStatistics') ?? [];
    });
  }

  // Save the current evaluation to SharedPreferences
  _saveStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    String entry = 'Mood Rating: ${moodRating.toStringAsFixed(1)}, Note: ${_noteController.text}';
    savedStatistics.insert(0, entry);  // Insert at the top
    await prefs.setStringList('savedStatistics', savedStatistics);
    setState(() {
      _noteController.clear(); // Clear the note after saving
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
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
            Text(
              'Evaluate Your Mood/Statistics',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Mood Slider to evaluate mood (0 to 10)
            Text('Mood Rating (0 - 10)', style: TextStyle(fontSize: 18)),
            Slider(
              value: moodRating,
              min: 0,
              max: 10,
              divisions: 10,
              label: moodRating.toStringAsFixed(1),
              onChanged: (double value) {
                setState(() {
                  moodRating = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Note input to add a message
            Text('Add a note', style: TextStyle(fontSize: 18)),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Any thoughts or notes about today?',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            SizedBox(height: 20),

            // Save Button
            ElevatedButton(
              onPressed: _saveStatistics,
              child: Text('Save Evaluation'),
            ),
            SizedBox(height: 20),

            // Display Saved Statistics
            Text(
              'Previous Evaluations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: savedStatistics.map((entry) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          entry,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
