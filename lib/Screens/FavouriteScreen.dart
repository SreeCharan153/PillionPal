import 'package:flutter/material.dart';
import '../widgets/AddressCard.dart';
import '../widgets/navbar.dart';
import '../widgets/MenuDrawer.dart';

class FavouriteScreen extends StatefulWidget {
  final bool isBikeMode;
  final List<String> favoritePlaces; // ✅ Add this parameter

  const FavouriteScreen({
    Key? key,
    required this.isBikeMode,
    required this.favoritePlaces, // ✅ Make it required
  }) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  List<Map<String, String>> favoriteAddresses = [];

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // ✅ Load saved favorite addresses
    _loadFavorites();
  }

  void _loadFavorites() {
    setState(() {
      favoriteAddresses =
          widget.favoritePlaces
              .map((place) => {"type": "Favorite", "address": place})
              .toList();
    });
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
      favoriteAddresses.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Address removed from favorites"),
        duration: Duration(seconds: 1),
      ),
    );
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
          Scaffold(
            appBar: AppBar(
              title: Text("Favourites", style: theme.textTheme.titleLarge),
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: _toggleMenu,
              ),
            ),
            body:
                favoriteAddresses.isEmpty
                    ? const Center(
                      child: Text(
                        "No favorite addresses added!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                    : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: favoriteAddresses.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: AddressCard(
                            locationType: favoriteAddresses[index]["type"]!,
                            address: favoriteAddresses[index]["address"]!,
                            locationColor: Colors.orange.shade700,
                            onRemove: () => _removeAddress(index),
                          ),
                        );
                      },
                    ),
            bottomNavigationBar: Navbar(
              selectedIndex: 1,
              isBikeMode: widget.isBikeMode,
            ),
          ),

          MenuDrawer(
            animationController: _menuController,
            isBikeMode: widget.isBikeMode,
          ),
        ],
      ),
    );
  }
}
