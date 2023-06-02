import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../controllers/day_chart.dart';

class TransChart extends StatefulWidget {
  const TransChart({super.key});

  @override
  State<TransChart> createState() => _TransChartState();
}

class _TransChartState extends State<TransChart> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Transaction States'),
      ),
      body: Container(
        width: width,
        height: height,
        child: LineChartSample1(),
      ),
    );
  }
}
