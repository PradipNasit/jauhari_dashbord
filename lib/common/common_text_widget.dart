import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;                  // The text to display
  final Color color;                  // The color of the text
  final double fontSize;              // The size of the font
  final FontWeight fontWeight;        // The weight of the font
  final TextAlign textAlign;          // The alignment of the text
  final int maxLines;                 // Maximum lines for the text
  final TextOverflow overflow;         // How to handle overflow

  // Constructor with default values
  CommonText({
    required this.text,
    this.color = Colors.black,         // Default text color
    this.fontSize = 14.0,              // Default font size
    this.fontWeight = FontWeight.normal,// Default font weight
    this.textAlign = TextAlign.start,  // Default text alignment
    this.maxLines = 1,                 // Default max lines
    this.overflow = TextOverflow.ellipsis, // Default overflow
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
