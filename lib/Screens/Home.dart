import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/navbar.dart';
import '../widgets/MenuDrawer.dart';

class HomeScreen extends StatefulWidget {
  final bool isBikeMode;

  const HomeScreen({super.key, required this.isBikeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _menuController.forward();
      } else {
        _menuController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Home Screen Content
          _buildHomeContent(),

          // Slide-Out Overlapping Menu Drawer
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: _isMenuOpen ? 0 : -250, // Moves off-screen when closed
            top: 0,
            bottom: 0,
            width: 250,
            child: MenuDrawer(), // Custom drawer widget
          ),
        ],
      ),
    );
  }

  Widget _buildHomeContent() {
    return GestureDetector(
      onTap: _isMenuOpen ? _toggleMenu : null, // Close menu on tap
      child: AbsorbPointer(
        absorbing: _isMenuOpen, // Prevent clicks when menu is open
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.black, // Background color
              ),
            ),

            // App Bar with Menu Button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.menu, size: 30, color: Colors.white),
                      onPressed: _toggleMenu,
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications, size: 30, color: Colors.white),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Icon(
                            widget.isBikeMode ? Icons.motorcycle : Icons.directions_walk,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(isBikeMode: !widget.isBikeMode),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Search Box and Transport Button
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 100),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Where would you go?",
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          prefixIcon: const Icon(Icons.search, color: Colors.white),
                          filled: true,
                          fillColor: Colors.black,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      PrimaryButton(text: "Transport", onPressed: () {}),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom Navigation Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Navbar(selectedIndex: 0),
            ),
          ],
        ),
      ),
    );
  }
}
