import 'package:flutter/material.dart';
import '../Screens/FavouriteScreen.dart'; // Import the FavoritesScreen

class CustomSearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isBikeMode; // ✅ Add this missing property

  const CustomSearchBar({
    super.key,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    required this.isBikeMode, // ✅ Ensure it's required
  });

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  List<String> allSuggestions = [
    "New York",
    "Los Angeles",
    "San Francisco",
    "Chicago",
    "Houston",
    "Miami",
    "Seattle",
    "Las Vegas"
  ];
  
  List<String> filteredSuggestions = [];
  bool showSuggestions = false;
  List<String> favoritePlaces = []; // Store favorite locations

  void _onTextChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        showSuggestions = false;
        filteredSuggestions = [];
      } else {
        showSuggestions = true;
        filteredSuggestions = allSuggestions
            .where((place) => place.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  void _onSuggestionSelected(String suggestion) {
    setState(() {
      widget.controller?.text = suggestion;
      showSuggestions = false;
    });

    if (widget.onSubmitted != null) {
      widget.onSubmitted!(suggestion);
    }
  }

  void _addToFavorites() {
    String currentText = widget.controller?.text ?? "";
    if (currentText.isNotEmpty && !favoritePlaces.contains(currentText)) {
      setState(() {
        favoritePlaces.add(currentText);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("$currentText added to favorites!"),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    // ✅ Fix: Pass `isBikeMode` dynamically
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavouriteScreen(
          favoritePlaces: favoritePlaces,
          isBikeMode: widget.isBikeMode, // ✅ Use the actual value
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFDFF3E7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF008955)),
          ),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  onChanged: _onTextChanged,
                  onSubmitted: widget.onSubmitted,
                  decoration: const InputDecoration(
                    hintText: "Where would you go?",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
                ),
              ),
              GestureDetector(
                onTap: _addToFavorites,
                child: const Icon(Icons.favorite_border, color: Colors.grey),
              ),
            ],
          ),
        ),

        if (showSuggestions)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: filteredSuggestions
                  .map((suggestion) => ListTile(
                        title: Text(suggestion),
                        onTap: () => _onSuggestionSelected(suggestion),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}
