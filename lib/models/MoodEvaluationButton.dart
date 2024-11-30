import 'package:flutter/material.dart';

class MoodEvaluationDialog extends StatefulWidget {
  @override
  _MoodEvaluationDialogState createState() => _MoodEvaluationDialogState();
}

class _MoodEvaluationDialogState extends State<MoodEvaluationDialog> {
  // Responses
  String? currentMood;
  String? stressLevel;
  bool hadSocialInteraction = false;
  double energyLevel = 3; // Scale 1-5
  double focusLevel = 3; // Scale 1-5
  double academicStressLevel = 3; // Scale 1-5
  bool tookBreaks = false;
  bool gotEnoughSleep = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Mood Evaluation"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            // Energy and Focus
            ExpansionTile(
              title: Text("Energy and Focus"),
              children: [
                _buildSlider(
                  label: "How energetic do you feel right now?",
                  value: energyLevel,
                  onChanged: (value) {
                    setState(() {
                      energyLevel = value;
                    });
                  },
                ),
                _buildSlider(
                  label: "How focused are you on your tasks?",
                  value: focusLevel,
                  onChanged: (value) {
                    setState(() {
                      focusLevel = value;
                    });
                  },
                ),
              ],
            ),
            // Emotional State
            ExpansionTile(
              title: Text("Emotional State"),
              children: [
                _buildDropdown(
                  label: "What emotion describes your mood?",
                  options: [
                    "😊 Happy",
                    "😟 Anxious",
                    "😢 Sad",
                    "😤 Frustrated",
                    "😌 Calm",
                    "🤩 Excited"
                  ],
                  value: currentMood,
                  onChanged: (value) {
                    setState(() {
                      currentMood = value;
                    });
                  },
                ),
                _buildDropdown(
                  label: "Are you feeling stressed?",
                  options: ["Not stressed", "Somewhat stressed", "Very stressed"],
                  value: stressLevel,
                  onChanged: (value) {
                    setState(() {
                      stressLevel = value;
                    });
                  },
                ),
              ],
            ),
            // Social Interaction
            ExpansionTile(
              title: Text("Social Interaction"),
              children: [
                _buildYesNoToggle(
                  label: "Have you had any meaningful social interactions today?",
                  value: hadSocialInteraction,
                  onChanged: (value) {
                    setState(() {
                      hadSocialInteraction = value;
                    });
                  },
                ),
              ],
            ),
            // Academic Stress
            ExpansionTile(
              title: Text("Academic Stress"),
              children: [
                _buildSlider(
                  label: "How overwhelmed are you by studies?",
                  value: academicStressLevel,
                  onChanged: (value) {
                    setState(() {
                      academicStressLevel = value;
                    });
                  },
                ),
              ],
            ),
            // Self-Care and Well-Being
            ExpansionTile(
              title: Text("Self-Care and Well-Being"),
              children: [
                _buildYesNoToggle(
                  label: "Have you taken breaks or done something relaxing today?",
                  value: tookBreaks,
                  onChanged: (value) {
                    setState(() {
                      tookBreaks = value;
                    });
                  },
                ),
                _buildYesNoToggle(
                  label: "Did you get enough sleep last night?",
                  value: gotEnoughSleep,
                  onChanged: (value) {
                    setState(() {
                      gotEnoughSleep = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            print("Mood: $currentMood");
            print("Stress Level: $stressLevel");
            print("Social Interaction: $hadSocialInteraction");
            print("Energy Level: $energyLevel");
            print("Focus Level: $focusLevel");
            print("Academic Stress Level: $academicStressLevel");
            print("Took Breaks: $tookBreaks");
            print("Got Enough Sleep: $gotEnoughSleep");
            Navigator.of(context).pop();
          },
          child: Text("Submit"),
        ),
      ],
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required void Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          value: value,
          min: 1,
          max: 5,
          divisions: 4,
          label: value.toString(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required List<String> options,
    required String? value,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(labelText: label),
      items: options.map((option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildYesNoToggle({
    required String label,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
