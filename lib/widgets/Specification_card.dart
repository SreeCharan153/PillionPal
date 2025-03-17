import 'package:flutter/material.dart';

class PowerCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final double padding;

  const PowerCard({
    super.key,
    required this.title,
    required this.value,
    this.icon = Icons.battery_charging_full,
    this.borderColor = const Color.fromRGBO(0, 137, 85, 1),
    this.backgroundColor = const Color(0xFFEFF8F1),
    this.textColor = Colors.black87,
    this.borderRadius = 12.0,
    this.padding = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: textColor, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(value, style: TextStyle(fontSize: 14, color: textColor)),
        ],
      ),
    );
  }
}
