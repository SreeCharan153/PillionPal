import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  final bool isBikeMode;

  const HomeScreen({super.key, required this.isBikeMode});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _notificationsEnabled = true; // Notification toggle state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Map (Placeholder)
          Positioned.fill(
            child: Container(
              color: Colors.grey[300], // Replace with actual map widget
            ),
          ),

          // Notification and Transport Mode Buttons
          Positioned(
            top: 30,
            right: 20,
            child: Column(
              children: [
                // Notification Button
                IconButton(
                  icon: Icon(
                    _notificationsEnabled
                        ? Icons.notifications_active
                        : Icons.notifications_off,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _notificationsEnabled = !_notificationsEnabled;
                    });
                  },
                ),
                const SizedBox(height: 10), // Space between buttons

                // Floating Icon (Bike or Walk)
                IconButton(
                  icon: Icon(
                    widget.isBikeMode ? Icons.motorcycle : Icons.directions_walk,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            HomeScreen(isBikeMode: !widget.isBikeMode),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Search Box and Transport Button with Themed Background
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(8, 183, 131, 1), // PillionPal theme color
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
                  // Search Input Field
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white),
                      color: Colors.white,
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "Where would you go?",
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Transport Button
                  PrimaryButton(
                    text: "Transport",
                    onPressed: () {
                      // Handle transport action
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Navbar(selectedIndex: 0),
    );
  }
}
