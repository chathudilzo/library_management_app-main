import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'db_helper.dart';

class _LineChart extends StatefulWidget {
  _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  State<_LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<_LineChart> {
  List<FlSpot> line1plots = [];

  List<FlSpot> line2plots = [];

  bool isLoading = true;
  bool isEmpty = false;

  var maxYY = 0.0;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var count = 0.0;

    final daysData = await DBHelper.getDays();
    if (daysData.isNotEmpty) {
      var maxY = 0.0;
      line1plots = daysData.map((day) {
        final issuedCount = (day['issued'] as int).toDouble();
        final returnedCount = (day['returned'] as int).toDouble();

        count = count + issuedCount + returnedCount;

        final index = daysData.indexOf(day).toDouble();

        return FlSpot(index, issuedCount);
      }).toList();
      //print('total count:$count');

      line2plots = daysData.map((day) {
        final issuedCount = (day['issued'] as int).toDouble();
        final returnedCount = (day['returned'] as int).toDouble();
        final index = daysData.indexOf(day).toDouble();
        if (maxY < issuedCount) {
          maxY = issuedCount;
        }
        if (maxY < returnedCount) {
          maxY = returnedCount;
        }
        return FlSpot(index, returnedCount);
      }).toList();
      //print(maxY);
      setState(() {
        maxYY = maxY;
        isLoading = false;
        if (count == 0.0) {
          isEmpty = true;
        }
      });
      // print(
      //    'row data line 1:${line1plots[0]}${line1plots[1]},${line1plots[2]}, ${line1plots[3]},  ${line1plots[4]},  ${line1plots[5]},  ${line1plots[6]}');
    } else {
      setState(() {
        isLoading = false;
        isEmpty = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return isLoading
        ? LoadingAnimationWidget.dotsTriangle(
            color: Color.fromARGB(255, 7, 206, 100),
            size: 50,
          )
        : isEmpty
            ? Center(
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/notfoundpenguine.gif'),
                              fit: BoxFit.cover)),
                    ),
                    Text('No data to show'),
                  ],
                ),
              )
            : Container(
                width: width,
                height: height,
                child: LineChart(
                  widget.isShowingMainData ? sampleData1 : sampleData2,
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 7,
        maxY: maxYY,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 7,
        maxY: maxYY,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        //lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  List<Widget> generateCases(double maxYY) {
    List<Widget> cases = [];

    for (int i = 0; i <= maxYY; i++) {
      cases.add(
        Container(
          child: Text('$i'),
        ),
      );
    }

    return cases;
  }

  // Widget leftTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: 5,
  //   );
  //   String text;
  //   switch (value.toInt()) {
  //     case 1:
  //       text = '1m';
  //       break;
  //     case 2:
  //       text = '2m';
  //       break;
  //     case 3:
  //       text = '3m';
  //       break;
  //     case 4:
  //       text = '5m';
  //       break;
  //     case 5:
  //       text = '6m';
  //       break;
  //     default:
  //       return Container();
  //   }

  //   return Text(text, style: style, textAlign: TextAlign.center);
  // }
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    List<Widget> cases = generateCases(maxYY);

    if (value >= 1 && value <= maxYY && value.floorToDouble() == value) {
      int index = value.floor();
      if (index >= 0 && index < cases.length) {
        return cases[index];
      }
    }

    return Container();
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Sun', style: style);
        break;
      case 1:
        text = const Text('Mon', style: style);
        break;
      case 2:
        text = const Text('Tue', style: style);
        break;
      case 3:
        text = const Text('Wed', style: style);
        break;
      case 4:
        text = const Text('Thu', style: style);
        break;
      case 5:
        text = const Text('Fri', style: style);
        break;
      case 6:
        text = const Text('Sat', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.blue.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Color.fromARGB(255, 3, 121, 6),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          line1plots[0],
          line1plots[1],
          line1plots[2],
          line1plots[3],
          line1plots[4],
          line1plots[5],
          line1plots[6],
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Color.fromARGB(255, 155, 2, 2),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: [
          line2plots[0],
          line2plots[1],
          line2plots[2],
          line2plots[3],
          line2plots[4],
          line2plots[5],
          line2plots[6],
        ],
      );

  // LineChartBarData get lineChartBarData1_3 => LineChartBarData(
  //       isCurved: true,
  //       color: Colors.cyan,
  //       barWidth: 8,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(show: false),
  //       spots: const [
  //         FlSpot(1, 2.8),
  //         FlSpot(3, 1.9),
  //         FlSpot(6, 3),
  //         FlSpot(10, 1.3),
  //         FlSpot(13, 2.5),
  //       ],
  //     );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.green.withOpacity(0.5),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          line1plots[0],
          line1plots[1],
          line1plots[2],
          line1plots[3],
          line1plots[4],
          line1plots[5],
          line1plots[6],
        ],
      );

  // LineChartBarData get lineChartBarData2_2 => LineChartBarData(
  //       isCurved: true,
  //       color: Colors.pink.withOpacity(0.5),
  //       barWidth: 4,
  //       isStrokeCapRound: true,
  //       dotData: FlDotData(show: false),
  //       belowBarData: BarAreaData(
  //         show: true,
  //         color: Colors.pink.withOpacity(0.2),
  //       ),
  //       spots: [
  //         line2plots[0],
  //         line2plots[1],
  //         line2plots[2],
  //         line2plots[3],
  //         line2plots[4],
  //         line2plots[5],
  //         line2plots[6],
  //       ],
  //     );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.cyan.withOpacity(0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: [
          line2plots[0],
          line2plots[1],
          line2plots[2],
          line2plots[3],
          line2plots[4],
          line2plots[5],
          line2plots[6],
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Weekly Transactions',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}































































































// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// import 'db_helper.dart';

// class BarChartSample2 extends StatefulWidget {
//   BarChartSample2({super.key});
//   final Color leftBarColor = Colors.yellow;
//   final Color rightBarColor = Colors.red;
//   final Color avgColor = Colors.orange;
//   @override
//   State<StatefulWidget> createState() => BarChartSample2State();
// }

// class BarChartSample2State extends State<BarChartSample2> {
//   final double width = 7;

//   late List<BarChartGroupData> rawBarGroups;
//   late List<BarChartGroupData> showingBarGroups = [];
//   late List<BarChartGroupData> barGroups;

//   int touchedGroupIndex = -1;

//   @override
//   void initState() {
//     super.initState();
//     rawBarGroups = [];
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     final daysData = await DBHelper.getDays();

//     barGroups = daysData.map((day) {
//       final issuedCount = day['issued'] as int;
//       final returnedCount = day['returned'] as int;
//       final index = daysData.indexOf(day);

//       return makeGroupData(
//         index,
//         issuedCount.toDouble(),
//         returnedCount.toDouble(),
//       );
//     }).toList();
//     print(barGroups);
//     setState(() {
//       rawBarGroups = List<BarChartGroupData>.from(barGroups);
//       showingBarGroups = List<BarChartGroupData>.from(rawBarGroups);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 makeTransactionsIcon(),
//                 const SizedBox(
//                   width: 38,
//                 ),
//                 const Text(
//                   'Transactions',
//                   style: TextStyle(color: Colors.white, fontSize: 22),
//                 ),
//                 const SizedBox(
//                   width: 4,
//                 ),
//                 const Text(
//                   'state',
//                   style: TextStyle(color: Color(0xff77839a), fontSize: 16),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 38,
//             ),
//             Expanded(
//               child: BarChart(
//                 BarChartData(
//                   maxY: 20,
//                   barTouchData: BarTouchData(
//                     touchTooltipData: BarTouchTooltipData(
//                       tooltipBgColor: Colors.grey,
//                       getTooltipItem: (a, b, c, d) => null,
//                     ),
//                     touchCallback: (FlTouchEvent event, response) {
//                       if (response == null || response.spot == null) {
//                         setState(() {
//                           touchedGroupIndex = -1;
//                           showingBarGroups = List.of(rawBarGroups);
//                         });
//                         return;
//                       }

//                       touchedGroupIndex = response.spot!.touchedBarGroupIndex;

//                       setState(() {
//                         if (!event.isInterestedForInteractions) {
//                           touchedGroupIndex = -1;
//                           showingBarGroups = List.of(rawBarGroups);
//                           return;
//                         }
//                         showingBarGroups = List.of(rawBarGroups);
//                         if (touchedGroupIndex != -1) {
//                           var sum = 0.0;
//                           for (final rod
//                               in showingBarGroups[touchedGroupIndex].barRods) {
//                             sum += rod.toY;
//                           }
//                           final avg = sum /
//                               showingBarGroups[touchedGroupIndex]
//                                   .barRods
//                                   .length;

//                           showingBarGroups[touchedGroupIndex] =
//                               showingBarGroups[touchedGroupIndex].copyWith(
//                             barRods: showingBarGroups[touchedGroupIndex]
//                                 .barRods
//                                 .map((rod) {
//                               return rod.copyWith(
//                                   toY: avg, color: widget.avgColor);
//                             }).toList(),
//                           );
//                         }
//                       });
//                     },
//                   ),
//                   titlesData: FlTitlesData(
//                     show: true,
//                     rightTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: bottomTitles,
//                         reservedSize: 42,
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         reservedSize: 28,
//                         interval: 1,
//                         getTitlesWidget: leftTitles,
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   barGroups: showingBarGroups,
//                   gridData: FlGridData(show: false),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget leftTitles(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Color(0xff7589a2),
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     if (value == 0) {
//       text = '1K';
//     } else if (value == 10) {
//       text = '5K';
//     } else if (value == 19) {
//       text = '10K';
//     } else {
//       return Container();
//     }
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 0,
//       child: Text(text, style: style),
//     );
//   }

//   Widget bottomTitles(double value, TitleMeta meta) {
//     final titles = <String>['Mn', 'Te', 'Wd', 'Tu', 'Fr', 'St', 'Su'];

//     final Widget text = Text(
//       titles[value.toInt()],
//       style: const TextStyle(
//         color: Color(0xff7589a2),
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//     );

//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16, //margin top
//       child: text,
//     );
//   }

//   BarChartGroupData makeGroupData(int x, double y1, double y2) {
//     return BarChartGroupData(
//       barsSpace: 4,
//       x: x,
//       barRods: [
//         BarChartRodData(
//           toY: y1,
//           color: widget.leftBarColor,
//           width: width,
//         ),
//         BarChartRodData(
//           toY: y2,
//           color: widget.rightBarColor,
//           width: width,
//         ),
//       ],
//     );
//   }

//   Widget makeTransactionsIcon() {
//     const width = 4.5;
//     const space = 3.5;
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Container(
//           width: width,
//           height: 10,
//           color: Colors.white.withOpacity(0.4),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Colors.white.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 42,
//           color: Colors.white.withOpacity(1),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 28,
//           color: Colors.white.withOpacity(0.8),
//         ),
//         const SizedBox(
//           width: space,
//         ),
//         Container(
//           width: width,
//           height: 10,
//           color: Colors.white.withOpacity(0.4),
//         ),
//       ],
//     );
//   }
// }

