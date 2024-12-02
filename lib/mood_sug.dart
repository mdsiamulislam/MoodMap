import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class MoodSug extends StatefulWidget {
  final List<String> selectedEmotion;
  MoodSug({Key? key, required this.selectedEmotion}) : super(key: key);

  @override
  State<MoodSug> createState() => _MoodSugState();
}

class _MoodSugState extends State<MoodSug> {
  final Map<String, TextEditingController> _descriptionControllers = {};
  final TextEditingController _commonController = TextEditingController();
  List<String> _selectedMoods = [];

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    String timestamp = DateFormat('hh:mm a dd MMM yyyy').format(DateTime.now());
    List<String> savedList = prefs.getStringList('moodLogs') ?? [];

    for (var mood in _selectedMoods) {
      final description = _descriptionControllers[mood]?.text ?? "";
      if (description.isNotEmpty) {
        String savedData = '$mood - $description - $timestamp';
        savedList.add(savedData);
      }
    }

    if (_commonController.text.isNotEmpty) {
      String commonData = 'Common Thoughts - ${_commonController.text} - $timestamp';
      savedList.add(commonData);
    }

    await prefs.setStringList('moodLogs', savedList);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mood saved successfully!')),
    );

    setState(() {
      _descriptionControllers.forEach((key, controller) {
        controller.clear();
      });
      _commonController.clear();
      _selectedMoods.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    for (var emotion in widget.selectedEmotion) {
      _descriptionControllers[emotion] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _descriptionControllers.values) {
      controller.dispose();
    }
    _commonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Logger'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Your Mood",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.selectedEmotion.map((emotion) {
                  bool isSelected = _selectedMoods.contains(emotion);
                  return ChoiceChip(
                    label: Text(
                      emotion,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.green[800],
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: Colors.green,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedMoods.add(emotion);
                        } else {
                          _selectedMoods.remove(emotion);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              ..._selectedMoods.map((mood) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Describe your mood ($mood):",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _descriptionControllers[mood],
                      decoration: InputDecoration(
                        labelText: "Write about $mood...",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.green[50],
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              }).toList(),
              Divider(color: Colors.grey),
              const SizedBox(height: 16),
              Text(
                "Additional Thoughts:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _commonController,
                decoration: InputDecoration(
                  labelText: "Write your additional thoughts here...",
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.green[50],
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_selectedMoods.isNotEmpty || _commonController.text.isNotEmpty) {
                    _saveData();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a mood or add a thought!'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Save Mood',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}