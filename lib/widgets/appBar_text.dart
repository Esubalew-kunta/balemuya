import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;

  CustomText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black, // Set the color of the text
        fontSize: 14, // Set the font size
        fontWeight: FontWeight.w300, // Set the font weight (light)
        letterSpacing: 1.2, // Adjust the letter spacing
      ),
    );
  }
}
