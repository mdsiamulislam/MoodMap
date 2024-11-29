import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MoodTrendsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Trends'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              leftTitles: SideTitles(showTitles: true),
              bottomTitles: SideTitles(showTitles: true),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                isCurved: true,
                spots: [
                  FlSpot(0, 3), // Day 1, Mood 3
                  FlSpot(1, 4), // Day 2, Mood 4
                  FlSpot(2, 2), // Day 3, Mood 2
                  FlSpot(3, 5), // Day 4, Mood 5
                  FlSpot(4, 3), // Day 5, Mood 3
                ],
                colors: [Colors.blue],
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
