import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String label;
  final String value;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double padding;

  const InfoCard({
    super.key,
    required this.label,
    required this.value,
    this.borderColor = const Color.fromRGBO(0, 137, 85, 1),
    this.backgroundColor = const Color(0xFFEFF8F1),
    this.textColor = Colors.black87,
    this.borderRadius = 12.0,
    this.padding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
