import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodBarChart extends StatelessWidget {
  final List<double> moodLevels; // List of mood levels (e.g., happiness/sadness)
  final String title;
  final String description;

  MoodBarChart({
    required this.moodLevels,
    this.title = "Mood Evaluation",
    this.description = "Weekly Mood Overview (Higher is happier and lower is sadder)",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 13, color: Colors.white70),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                barGroups: _buildBarGroups(),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        return Text(
                          _getWeekDay(value.toInt()),
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return moodLevels
        .asMap()
        .entries
        .map(
          (entry) => BarChartGroupData(
        x: entry.key,
        barRods: [
          BarChartRodData(
            toY: entry.value,
            color: entry.value > 10 ? Colors.green : Colors.red,
            width: 18,
          ),
        ],
      ),
    )
        .toList();
  }

  String _getWeekDay(int index) {
    const weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekDays[index % weekDays.length];
  }
}