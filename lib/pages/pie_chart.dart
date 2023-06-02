import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/db_helper.dart';
import 'package:library_pc/controllers/pie_chart_controller.dart';
import 'package:library_pc/pages/pie_chart_wid.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PieChartScreen extends StatefulWidget {
  const PieChartScreen({super.key});

  @override
  State<PieChartScreen> createState() => _PieChartScreenState();
}

class _PieChartScreenState extends State<PieChartScreen> {
  final PieChartController _controller = Get.put(PieChartController());
  // bool _isEmpty = false;
  // bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_controller.getData();
  }

  // void getData() async {
  //   final list = await DBHelper.getGenreList();
  //   setState(() {
  //     _isLoading = false;
  //     if (list.isEmpty) {
  //       _isEmpty = true;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _controller.isLoading.value
        ? Center(
            child: LoadingAnimationWidget.inkDrop(
                color: Color.fromARGB(255, 6, 175, 71), size: 50))
        : _controller.isEmpty.value
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LoadingAnimationWidget.inkDrop(color: Colors.red, size: 50),
                  Text('No data to show ')
                ],
              ))
            : FutureBuilder<List<Map<String, dynamic>>>(
                future: Future.value(_controller.genreData),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final genreList =
                        snapshot.data as List<Map<String, dynamic>>;
                    return PieChartWid(genreList: genreList);
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: Colors.red, size: 100));
                  }
                },
              ));
  }
}
