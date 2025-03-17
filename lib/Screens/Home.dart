import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/Screens/NotificationScreen.dart';
import 'package:pillionpal/Screens/bike_list_page.dart';
import 'package:pillionpal/widgets/maps.dart'; // ✅ Import Map
import '../widgets/PrimaryButton.dart';
import '../widgets/navbar.dart';
import '../widgets/MenuDrawer.dart';
import '../widgets/CustomSearchBar.dart';
import '../widgets/EnableLocationDialog.dart';

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

    _checkLocationPermission(); // ✅ Check permission on startup
  }

  // 🔹 Check & Request Location Permission
  Future<void> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      bool granted = await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        barrierDismissible: false,
        builder: (context) => const EnableLocationDialog(),
      );

      if (granted == true) {
        _getCurrentLocation();
      } else {
        debugPrint("User skipped enabling location.");
      }
    } else {
      _getCurrentLocation();
    }
  }

  // 🔹 Get Current Location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      debugPrint("User Location: ${position.latitude}, ${position.longitude}");
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
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
  }

  void _toggleMode() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(isBikeMode: !widget.isBikeMode),
      ),
    );
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
          // ✅ Show the Map in the background
          const Positioned.fill(
            child: MapBox(),
          ),
          
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: 30),
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
                              Get.to(NotificationScreen());
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
                        onChanged: _handleSearch,
                        onSubmitted: _handleSearch,
                        isBikeMode: widget.isBikeMode,
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
