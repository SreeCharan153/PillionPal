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
  late Animation<double> _menuAnimation;

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
          // Main Content (doesn't shift)
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
                                  builder:
                                      (context) => HomeScreen(
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

                // Search & Transport
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
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Where would you go?",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
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
                    child: MenuDrawer(animationController: _menuController),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Navbar(selectedIndex: 0,isBikeMode: widget.isBikeMode,),
    );
  }
}
