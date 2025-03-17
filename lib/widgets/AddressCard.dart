import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final String locationType;
  final String address;
  final Color locationColor;
  final VoidCallback onRemove;

  const AddressCard({
    super.key,
    required this.locationType,
    required this.address,
    required this.locationColor,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor, // Adapting to theme
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color:
                theme.brightness == Brightness.light
                    ? Colors.black12
                    : Colors.white12, // Adapt shadow color
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Location Icon
          Icon(Icons.location_on, color: theme.iconTheme.color ?? Colors.grey),

          const SizedBox(width: 10),

          // Location Type and Address
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  locationType,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: locationColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  address,
                  style: theme.textTheme.bodyMedium, // Use theme text style
                ),
              ],
            ),
          ),

          // Remove Button
          IconButton(
            icon: Icon(Icons.remove_circle, color: Colors.red.shade700),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
