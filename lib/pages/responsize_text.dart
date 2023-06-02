import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const ResponsiveText(
      {required this.text,
      required this.fontSize,
      required this.color,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate the responsive font size based on screen width
    double responsiveFontSize = fontSize * screenWidth / 375.0;

    return Text(
      text,
      style: TextStyle(
          fontSize: responsiveFontSize, color: color, fontWeight: fontWeight),
    );
  }
}
