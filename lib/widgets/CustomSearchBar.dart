import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted; // New parameter for handling submission
  final VoidCallback? onFavoriteTap;

  const CustomSearchBar({
    Key? key,
    this.controller,
    this.onChanged,
    this.onSubmitted, // Include this in the constructor
    this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF3E7), // Light greenish background
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF008955)), // Green border
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted, // Pass to TextField
              decoration: const InputDecoration(
                hintText: "Where would you go?",
                border: InputBorder.none, // Removes default border
              ),
              style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
            ),
          ),
          GestureDetector(
            onTap: onFavoriteTap,
            child: const Icon(Icons.favorite_border, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
