import "package:flutter/material.dart";

// Text Widget
class MyText extends StatelessWidget {
  const MyText(this.text, this.fontSize, {super.key});
  final String text;
  final double fontSize;

  // Styling
  TextStyle get myTextStyle => TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      );

  @override
  Widget build(context) {
    return Text(
      text,
      style: myTextStyle,
    );
  }
}
