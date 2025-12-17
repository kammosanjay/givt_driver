import 'package:flutter/material.dart';

class MyCustomWidgets {
  // TextStyle for consistent text styling across the app
 static textstyle({
    double fontSize = 16,
    Color textColor = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: textColor,
      fontWeight: fontWeight,
    );
  }
  //

  static buttonStyle({
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    double fontSize = 16,
    double width = 150,
    double height = 50,
  }) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      fixedSize: Size(width, height),
      textStyle: TextStyle(fontSize: fontSize, color: textColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      
    );
  }
}
