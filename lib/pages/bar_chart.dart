import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/bar_chart_controller.dart';

class BarChartWid extends StatefulWidget {
  const BarChartWid({
    super.key,
  });

  // final available;
  // final total;
  // final checked;

  @override
  State<BarChartWid> createState() => _BarChartWidState();
}

class _BarChartWidState extends State<BarChartWid> {
  final BarChartController _controller = Get.put(BarChartController());
  // List<int> _bookAvailableData = [];
  // int available = 0;
  // int total = 0;
  // int checked = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getData();
  }

  // void updateData(double total, double available, double checked) {
  //   setState(() {
  //     this.total = total as int;
  //     this.available = available as int;
  //     this.checked = checked as int;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _controller.booksAvailibilityData.isNotEmpty
          ? Container(
              child: BarChart(
              BarChartData(
                barTouchData: barTouchData,
                titlesData: titlesData,
                borderData: borderData,
                barGroups: barGroups,
              ),
            ))
          : CircularProgressIndicator();
    });
  }

  BarTouchData get barTouchData => BarTouchData(
      enabled: false,
      touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (BarChartGroupData group, int groupIndex,
              BarChartRodData rod, int rodIndex) {
            return BarTooltipItem(
                rod.toY.round().toString(),
                const TextStyle(
                    color: Colors.amberAccent, fontWeight: FontWeight.bold));
          }));

  Widget getTitles(double value, TitleMeta meta) {
    String text = '';
    int index = 1;
    switch (value.toInt()) {
      case 0:
        text = 'Total';
        index = 1;
        break;
      case 1:
        text = 'Available';
        index = 2;
        break;
      case 2:
        text = 'Checked Out';
        index = 3;
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 4,
        child: Text(text,
            style: TextStyle(
                color: index == 1
                    ? Colors.blueAccent
                    : index == 2
                        ? Colors.greenAccent
                        : Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 14)));
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true, reservedSize: 30, getTitlesWidget: getTitles),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  LinearGradient _barsGradient(int index) {
    switch (index) {
      case 0:
        return LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.cyan,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
      case 1:
        return LinearGradient(
          colors: [
            Colors.blueAccent,
            Colors.cyan,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
      case 2:
        return LinearGradient(
          colors: [
            Colors.greenAccent,
            Colors.green,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
      default:
        return LinearGradient(
          colors: [
            Colors.redAccent,
            Colors.red,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        );
        ;
    }
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
                toY: _controller.booksAvailibilityData[1].toDouble(),
                gradient: _barsGradient(1))
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
                toY: _controller.booksAvailibilityData[0].toDouble(),
                gradient: _barsGradient(2))
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
                toY: _controller.booksAvailibilityData[2].toDouble(),
                gradient: _barsGradient(3))
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
