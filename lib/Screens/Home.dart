import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/navbar.dart';
import '../widgets/MenuDrawer.dart';
import '../widgets/CustomSearchBar.dart';

class HomeScreen extends StatefulWidget {
  final bool isBikeMode;

  const HomeScreen({super.key, required this.isBikeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _menuAnimation = Tween<double>(begin: -250, end: 0).animate(
      CurvedAnimation(parent: _menuController, curve: Curves.easeInOut),
    );
  }

  void _toggleMenu() {
    if (_menuController.isCompleted) {
      _menuController.reverse();
    } else {
      _menuController.forward();
    }
  }

  void _onSearchSubmitted(String query) {
    // Handle the search logic (API call, navigation, etc.)
    print("User searched for: $query");
  }

  @override
  void dispose() {
    _menuController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 30),

                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, size: 30),
                        onPressed: _toggleMenu,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications, size: 30),
                            onPressed: () {},
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(
                              widget.isBikeMode
                                  ? Icons.motorcycle
                                  : Icons.directions_walk,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(
                                    isBikeMode: !widget.isBikeMode,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Search Bar & Transport Button
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomSearchBar(
                        controller: _searchController,
                        onChanged: (text) {
                          print("User is typing: $text");
                        },
                        onSubmitted: _onSearchSubmitted,
                        onFavoriteTap: () {
                          print("Favorite Icon Tapped");
                          // Navigate to the favorite places screen if needed
                        },
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(text: "Transport", onPressed: () {}),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // Slide-out Menu (Overlays)
          AnimatedBuilder(
            animation: _menuController,
            builder: (context, child) {
              return Stack(
                children: [
                  // Dimmed background when menu opens
                  if (_menuController.isCompleted ||
                      _menuController.isAnimating)
                    GestureDetector(
                      onTap: _toggleMenu,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  // Menu Drawer
                  Positioned(
                    left: _menuAnimation.value,
                    top: 0,
                    bottom: 0,
                    child: MenuDrawer(
                      animationController: _menuController,
                      isBikeMode: widget.isBikeMode,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        isBikeMode: widget.isBikeMode,
      ),
    );
  }
}
