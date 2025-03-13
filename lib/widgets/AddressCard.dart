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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Location Icon
          const Icon(Icons.location_on, color: Colors.grey),

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
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Remove Button
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
