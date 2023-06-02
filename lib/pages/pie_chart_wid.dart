import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWid extends StatefulWidget {
  const PieChartWid({Key? key, required this.genreList}) : super(key: key);
  final List<Map<String, dynamic>> genreList;

  @override
  _PieChartWidState createState() => _PieChartWidState();
}

class _PieChartWidState extends State<PieChartWid> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    //print(widget.genreList);
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                        //print(touchedIndex);
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 30,
                  sections: getSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: getIndicators(),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getSections() {
    return widget.genreList.asMap().entries.map((entry) {
      final genre = entry.value;
      final index = entry.key;
      final genreName = genre['Genre_No'] as String;
      final count = genre['Count'] as int;
      final isTouched = index == touchedIndex;

      if (isTouched) {
        // print(touchedIndex);
      }
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      final shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: getRandomColor(),
        value: count.toDouble(),
        title: count.toString(),
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
        badgeWidget: Text(
          genreName.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        badgePositionPercentageOffset: 0.98,
      );
    }).toList();
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  List<Widget> getIndicators() {
    return widget.genreList.map((genre) {
      final genreName = genre['Genre_No'] as String;
      final color = getRandomColor();
      return Padding(
        padding: const EdgeInsets.only(left: 5, bottom: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(width: 5),
            Text(
              genreName,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 245, 243, 243),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
