import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color borderColor;
  final IconData trailingIcon;

  const SettingsTile({
    super.key,
    required this.title,
    required this.onTap,
    this.borderColor = const Color.fromRGBO(
      0,
      137,
      85,
      1,
    ), // Default PillionPal green
    this.trailingIcon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Icon(trailingIcon, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
