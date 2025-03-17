import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? borderColor;
  final IconData trailingIcon;

  const SettingsTile({
    super.key,
    required this.title,
    required this.onTap,
    this.borderColor, // Removed default, will adapt to the theme
    this.trailingIcon = Icons.chevron_right,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Get the current theme
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface, // Adaptive background color
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: borderColor ?? theme.colorScheme.outline, // Adaptive border
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface, // Adaptive text color
              ),
            ),
            Icon(
              trailingIcon,
              color: isDarkMode ? Colors.white70 : Colors.grey, // Adaptive icon
            ),
          ],
        ),
      ),
    );
  }
}
