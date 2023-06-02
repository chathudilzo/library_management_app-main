import 'package:flutter/material.dart';

import '../controllers/book_data.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Container(
          width: width / 4,
          height: height / 1.5,
          color: Colors.amberAccent,
          child: BookInfo(),
        ),
      ),
    );
  }
}
