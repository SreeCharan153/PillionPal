import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/Screens/bike_list_page.dart';
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
    if (_menuController.status == AnimationStatus.completed) {
      _menuController.reverse();
    } else {
      _menuController.forward();
    }
  }

  void _handleSearch(String value) {
    debugPrint("User searched for: $value");
    // TODO: Implement search logic (API call or navigation)
  }

  void _handleTyping(String value) {
    debugPrint("User is typing: $value");
    // TODO: Implement suggestions logic
  }

  void _toggleMode() {
    setState(() {
      // Toggle between Bike and Walk mode without full rebuild
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(isBikeMode: !widget.isBikeMode),
        ),
      );
    });
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
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 30),

                // 🔹 Top Navigation Bar
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
                            onPressed: () {
                              // TODO: Implement notifications
                            },
                          ),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: Icon(
                              widget.isBikeMode
                                  ? Icons.motorcycle
                                  : Icons.directions_walk,
                              size: 30,
                            ),
                            onPressed: _toggleMode,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // 🔹 Search Bar & Transport Button
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
                        onChanged: _handleTyping,
                        onSubmitted: _handleSearch,
                        isBikeMode:
                            widget
                                .isBikeMode, // ✅ Pass the value from HomeScreen
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(
                        text: "Transport",
                        onPressed: () {
                          if (!widget.isBikeMode) {
                            Get.to(const BikeListPage());
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const Spacer(),
              ],
            ),
          ),

          // 🔹 Sliding Menu Drawer with Animation
          AnimatedBuilder(
            animation: _menuController,
            builder: (context, child) {
              return Stack(
                children: [
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
