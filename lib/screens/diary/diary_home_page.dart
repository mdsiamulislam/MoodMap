import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';  // Import the intl package

class DiaryHomePage extends StatefulWidget {
  const DiaryHomePage({super.key});

  @override
  State<DiaryHomePage> createState() => _DiaryHomePageState();
}

class _DiaryHomePageState extends State<DiaryHomePage> {
  int currentPageIndex = 2;
  TextEditingController _diaryController = TextEditingController();
  List<String> previousEntries = [];

  @override
  void initState() {
    super.initState();
    _loadDiaryEntries();
  }

  // Load diary entries from SharedPreferences
  _loadDiaryEntries() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      previousEntries = prefs.getStringList('diaryEntries') ?? [];
    });
  }

  // Save diary entry to SharedPreferences
  _saveDiaryEntry(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    previousEntries.insert(0, entry); // Insert the new entry at the top of the list
    await prefs.setStringList('diaryEntries', previousEntries); // Save the updated list
  }

  // Format the current date and time
  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a dd MMM yyyy'); // Format the time as '8:00 PM 30 Nov 2024'
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary'),
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
            // Title for daily entry
            Text(
              'Write your diary entry for today:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Text field for diary entry
            TextField(
              controller: _diaryController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'What happened today?',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              ),
            ),
            SizedBox(height: 16),
            // Button to save the diary entry
            ElevatedButton(
              onPressed: () {
                if (_diaryController.text.isNotEmpty) {
                  final entry = '${_getFormattedDate()} - ${_diaryController.text}';
                  _saveDiaryEntry(entry); // Save the entry with current date and time
                  setState(() {
                    _diaryController.clear(); // Clear the text field after saving
                  });
                }
              },
              child: Text('Save Diary Entry'),
            ),
            SizedBox(height: 16),
            // View previous diary entries
            Text(
              'Previous Diary Entries:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SingleChildScrollView(  // Added ScrollView to handle overflow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: previousEntries.map((entry) {
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
