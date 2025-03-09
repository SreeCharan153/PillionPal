// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final double borderWidth;
  final double fontSize;
  final FontWeight fontWeight;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity, // Makes it adaptive
    this.height = 50,
    this.borderColor = const Color(0xFF087B46), // Default Green Border
    this.textColor = const Color(0xFF087B46), // Default Green Text
    this.borderRadius = 8.0, // Slightly rounded corners
    this.borderWidth = 1.5, // Medium thickness
    this.fontSize = 16, // Balanced text size
    this.fontWeight = FontWeight.w600, // Semi-bold
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ), // Customizable Border
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: textColor,
            letterSpacing: 0.5, // Enhances readability
          ),
        ),
      ),
    );
  }
}
