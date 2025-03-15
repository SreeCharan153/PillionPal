import 'package:flutter/material.dart';
import '../widgets/AddressCard.dart';
import '../widgets/navbar.dart';
import '../widgets/MenuDrawer.dart';

class FavouriteScreen extends StatefulWidget {
  final bool isBikeMode;

  const FavouriteScreen({super.key, required this.isBikeMode});

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> with SingleTickerProviderStateMixin {
  late AnimationController _menuController;

  List<Map<String, String>> addresses = [
    {"type": "Office", "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486"},
    {"type": "Home", "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486"},
    {"type": "Office", "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486"},
    {"type": "House", "address": "2972 Westheimer Rd. Santa Ana, Illinois 85486"},
  ];

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _toggleMenu() {
    if (_menuController.isCompleted) {
      _menuController.reverse();
    } else {
      _menuController.forward();
    }
  }

  void _removeAddress(int index) {
    setState(() {
      addresses.removeAt(index);
    });
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // ✅ Main Content
          Scaffold(
            appBar: AppBar(
              title: Text("Favourites", style: theme.textTheme.titleLarge),
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu), // ✅ Menu Button
                onPressed: _toggleMenu,
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
              selectedIndex: 1, // Active tab index (Favourites)
              isBikeMode: widget.isBikeMode,
            ),
          ),

          // ✅ Sliding MenuDrawer
          MenuDrawer(animationController: _menuController, isBikeMode: widget.isBikeMode),
        ],
      ),
    );
  }
}
