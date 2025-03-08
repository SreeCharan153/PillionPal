import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;

  const SecondaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
    this.borderColor = const Color(0xFF087B46), // Default Green Border
    this.textColor = const Color(0xFF087B46), // Default Green Text
    this.borderRadius = 10.0, // Default border radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 2), // Border style
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
