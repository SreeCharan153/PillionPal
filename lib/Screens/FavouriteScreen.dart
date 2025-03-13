import 'package:flutter/material.dart';
import '../widgets/AddressCard.dart';
import '../widgets/navbar.dart';
import 'Home.dart';

class FavouriteScreen extends StatefulWidget {
  final bool isBikeMode; // Accept isBikeMode

  const FavouriteScreen({super.key, required this.isBikeMode});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<Map<String, String>> addresses = [
    {
      "type": "Office",
      "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486",
    },
    {
      "type": "Home",
      "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486",
    },
    {
      "type": "Office",
      "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486",
    },
    {
      "type": "House",
      "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486",
    },
  ];

  void _removeAddress(int index) {
    setState(() {
      addresses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite", style: theme.textTheme.titleLarge),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(isBikeMode: widget.isBikeMode),
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: AddressCard(
              locationType: addresses[index]["type"]!,
              address: addresses[index]["address"]!,
              locationColor: Colors.orange.shade700,
              onRemove: () => _removeAddress(index),
            ),
          );
        },
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 1,
        isBikeMode: widget.isBikeMode,
      ), // Preserve isBikeMode
    );
  }
}
