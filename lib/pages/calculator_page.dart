import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:library_pc/controllers/cal_controller.dart';

import '../admin_page.dart';
import 'issued_books.dart';
import 'profile.dart';
import 'view_book_page.dart';
import 'view_users.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({super.key});

  final List<String> buttonValues = [
    '7',
    '8',
    '9',
    '/',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '-',
    '0',
    '.',
    '=',
    '+',
  ];
  final CalculateController calController = Get.put(CalculateController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        actions: [
          IconButton(
              hoverColor: Color.fromARGB(255, 96, 102, 104),
              tooltip: 'Home',
              onPressed: () => Get.to(() => AdminPage()),
              icon: Icon(Icons.home)),
          IconButton(
              hoverColor: Color.fromARGB(255, 96, 102, 104),
              tooltip: 'View Books',
              onPressed: () => Get.to(() => ViewBooks()),
              icon: Icon(Icons.book)),
          IconButton(
              hoverColor: Color.fromARGB(255, 96, 102, 104),
              tooltip: 'View Users',
              onPressed: () => Get.to(() => ViewUsers()),
              icon: Icon(Icons.person)),
          IconButton(
              hoverColor: Color.fromARGB(255, 96, 102, 104),
              tooltip: 'View Issued Books',
              onPressed: () => Get.to(() => IssuedBooks()),
              icon: Icon(Icons.menu_book_sharp)),
          IconButton(
              hoverColor: Color.fromARGB(255, 96, 102, 104),
              tooltip: 'Settings',
              onPressed: () => Get.to(() => ProfileSetting()),
              icon: Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: Container(
          width: width * 0.4,
          height: height * 0.8,
          decoration: BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 7)],
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 71, 69, 77),
                Color.fromARGB(255, 25, 23, 26)
              ]),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                width: width * 0.35,
                height: height * 0.18,
                padding: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.green),
                    boxShadow: [BoxShadow(blurRadius: 7)],
                    color: Color.fromARGB(255, 42, 41, 41),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => Container(
                            child: Row(
                          children: [
                            Expanded(child: Container()),
                            Text(
                              '${calController.equation.value}',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ))),
                    Obx(() => Container(
                            child: Row(
                          children: [
                            Expanded(child: Container()),
                            Text('${calController.result.value}',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.greenAccent)),
                          ],
                        ))),
                  ],
                ),
              ),
              Container(
                width: width * 0.34,
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    GestureDetector(
                      onTap: () {
                        calController.clear();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        width: width * 0.04,
                        height: height * 0.07,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 255, 13, 0),
                                width: 2),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 7,
                                  spreadRadius: 5,
                                  offset: Offset(1, 3))
                            ],
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromARGB(255, 47, 47, 48)),
                        child: Center(
                            child: Text(
                          'AC',
                          style: TextStyle(fontSize: 20),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: width * 0.5,
                  height: height * 0.4,
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, row) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            for (var i = row * 4; i < (row * 4) + 4; i++)
                              GestureDetector(
                                onTap: () {
                                  String value = buttonValues[i];
                                  if (value == '=') {
                                    calController.calculateResult();
                                  } else {
                                    calController.addToEquation(value);
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  width: width * 0.04,
                                  height: height * 0.07,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: buttonValues[i] == '/' ||
                                                  buttonValues[i] == '*' ||
                                                  buttonValues[i] == '+' ||
                                                  buttonValues[i] == '-'
                                              ? Color.fromARGB(255, 0, 136, 255)
                                              : buttonValues[i] == '='
                                                  ? Colors.greenAccent
                                                  : Colors.orange,
                                          width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 7,
                                            spreadRadius: 5,
                                            offset: Offset(1, 3))
                                      ],
                                      borderRadius: BorderRadius.circular(50),
                                      color: Color.fromARGB(255, 47, 47, 48)),
                                  child: Center(
                                      child: Text(
                                    buttonValues[i],
                                    style: TextStyle(fontSize: 20),
                                  )),
                                ),
                              )
                          ],
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
