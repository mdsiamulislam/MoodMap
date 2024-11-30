import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartSample extends StatefulWidget {
  const LineChartSample({super.key});

  @override
  State<LineChartSample> createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: LineChart(
              showAvg ? LineChartDataFactory.avgData() : LineChartDataFactory.mainData(),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: SizedBox(
            width: 60,
            height: 34,
            child: TextButton(
              onPressed: () {
                setState(() {
                  showAvg = !showAvg;
                });
              },
              child: Text(
                'avg',
                style: TextStyle(
                  fontSize: 12,
                  color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LineChartDataFactory {
  static LineChartData mainData() {
    return LineChartData(
      gridData: _gridData(),
      titlesData: _titlesData(),
      borderData: _borderData(),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          gradient: _gradient(),
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: _gradient(opacity: 0.3),
          ),
        ),
      ],
    );
  }

  static LineChartData avgData() {
    return LineChartData(
      gridData: _gridData(),
      titlesData: _titlesData(),
      borderData: _borderData(),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: _gradient(),
          barWidth: 5,
          isStrokeCapRound: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: _gradient(opacity: 0.1),
          ),
        ),
      ],
    );
  }

  static FlGridData _gridData() {
    return FlGridData(
      show: true,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) =>
      const FlLine(color: Color(0xff37434d), strokeWidth: 1),
      getDrawingVerticalLine: (value) =>
      const FlLine(color: Color(0xff37434d), strokeWidth: 1),
    );
  }

  static FlTitlesData _titlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          reservedSize: 30,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
            switch (value.toInt()) {
              case 2:
                return const Text('MAR', style: style);
              case 5:
                return const Text('JUN', style: style);
              case 8:
                return const Text('SEP', style: style);
              default:
                return const Text('', style: style);
            }
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          reservedSize: 42,
          getTitlesWidget: (value, meta) {
            const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
            switch (value.toInt()) {
              case 1:
                return const Text('10K', style: style);
              case 3:
                return const Text('30K', style: style);
              case 5:
                return const Text('50K', style: style);
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }

  static FlBorderData _borderData() {
    return FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d), width: 1),
    );
  }

  static LinearGradient _gradient({double opacity = 1}) {
    return LinearGradient(
      colors: [
        const Color(0xff23b6e6).withOpacity(opacity),
        const Color(0xff02d39a).withOpacity(opacity),
      ],
    );
  }
}
