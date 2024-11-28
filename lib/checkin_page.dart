import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CheckInPage extends StatefulWidget {
  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  // Variables to store responses
  double energyLevel = 3.0;
  double focusLevel = 3.0;
  String currentMood = 'Happy';
  bool feelingStressed = false;
  double stressLevel = 2.0;
  bool hadSocialInteraction = false;
  double supportLevel = 3.0;
  double academicStress = 2.0;
  double confidenceLevel = 3.0;
  bool tookBreaks = false;
  double sleepHours = 6.0;

  // Data for the graph
  List<BarChartGroupData> graphData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Check-In"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Energy Level
            Text("How energetic do you feel right now?"),
            Slider(
              value: energyLevel,
              min: 1,
              max: 5,
              divisions: 4,
              label: energyLevel.toString(),
              onChanged: (value) {
                setState(() {
                  energyLevel = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Focus Level
            Text("How focused are you on your tasks?"),
            Slider(
              value: focusLevel,
              min: 1,
              max: 5,
              divisions: 4,
              label: focusLevel.toString(),
              onChanged: (value) {
                setState(() {
                  focusLevel = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Current Mood
            Text("Which emotion best describes your mood?"),
            DropdownButton<String>(
              value: currentMood,
              onChanged: (String? newValue) {
                setState(() {
                  currentMood = newValue!;
                });
              },
              items: <String>[
                'Happy',
                'Anxious',
                'Sad',
                'Frustrated',
                'Calm',
                'Excited'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),

            // Stress
            Text("Are you feeling stressed?"),
            Switch(
              value: feelingStressed,
              onChanged: (value) {
                setState(() {
                  feelingStressed = value;
                });
              },
            ),
            if (feelingStressed) ...[
              Text("How stressed are you?"),
              Slider(
                value: stressLevel,
                min: 1,
                max: 5,
                divisions: 4,
                label: stressLevel.toString(),
                onChanged: (value) {
                  setState(() {
                    stressLevel = value;
                  });
                },
              ),
            ],
            SizedBox(height: 16),

            // Social Interaction
            Text("Have you had meaningful social interactions today?"),
            Switch(
              value: hadSocialInteraction,
              onChanged: (value) {
                setState(() {
                  hadSocialInteraction = value;
                });
              },
            ),
            Text("Do you feel supported by people around you?"),
            Slider(
              value: supportLevel,
              min: 1,
              max: 5,
              divisions: 4,
              label: supportLevel.toString(),
              onChanged: (value) {
                setState(() {
                  supportLevel = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Academic Stress
            Text("Are you feeling overwhelmed by your studies?"),
            Slider(
              value: academicStress,
              min: 1,
              max: 5,
              divisions: 4,
              label: academicStress.toString(),
              onChanged: (value) {
                setState(() {
                  academicStress = value;
                });
              },
            ),
            Text("How confident are you in managing deadlines?"),
            Slider(
              value: confidenceLevel,
              min: 1,
              max: 5,
              divisions: 4,
              label: confidenceLevel.toString(),
              onChanged: (value) {
                setState(() {
                  confidenceLevel = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Self-Care
            Text("Have you taken breaks today?"),
            Switch(
              value: tookBreaks,
              onChanged: (value) {
                setState(() {
                  tookBreaks = value;
                });
              },
            ),
            Text("How many hours did you sleep last night?"),
            Slider(
              value: sleepHours,
              min: 0,
              max: 12,
              divisions: 12,
              label: sleepHours.toString(),
              onChanged: (value) {
                setState(() {
                  sleepHours = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Submit Button
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Update graph data based on responses
                  graphData = [
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: energyLevel)]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: focusLevel)]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: stressLevel)]),
                    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: supportLevel)]),
                    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: academicStress)]),
                  ];
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GraphPage(graphData: graphData),
                  ),
                );
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
class GraphPage extends StatelessWidget {
  final List<BarChartGroupData> graphData;

  GraphPage({required this.graphData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Insights"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            barGroups: graphData,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    switch (value.toInt()) {
                      case 1:
                        return Text("Energy");
                      case 2:
                        return Text("Focus");
                      case 3:
                        return Text("Stress");
                      case 4:
                        return Text("Support");
                      case 5:
                        return Text("Studies");
                      default:
                        return Text("");
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
