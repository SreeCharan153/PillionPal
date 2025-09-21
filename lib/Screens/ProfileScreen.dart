import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/Navbar.dart';
import '../widgets/MenuDrawer.dart';
import '../api_service.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final bool isBikeMode;
  const ProfileScreen({super.key, required this.isBikeMode});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _menuController;
  late ApiService apiService;

  @override
  void initState() {
    super.initState();
    _menuController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _initializeApiService();
  }

  Future<void> _initializeApiService() async {
    apiService = await ApiService.getInstance();
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_menuController.isCompleted) {
      _menuController.reverse();
    } else {
      _menuController.forward();
    }
  }

  Future<void> _confirmLogout() async {
    bool? confirm = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      // Call singleton logout
      await apiService.logout();

      // Navigate safely
      Get.offAll(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text("Profile", style: theme.textTheme.titleLarge),
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: _toggleMenu,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: theme.scaffoldBackgroundColor,
                          child: const Icon(Icons.person, size: 50),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Nate Samson",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _infoCard("Email", "nate@email.com", leadingIcon: Icons.email),
                  _infoCard("Phone", "+91 9876543210", leadingIcon: Icons.phone),
                  _infoCard("Gender", "Male", leadingIcon: Icons.person),
                  _infoCard("Address", "123, Street Name, City, India", leadingIcon: Icons.location_on),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _confirmLogout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.scaffoldBackgroundColor,
                      side: const BorderSide(color: Colors.white, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    ),
                    child: const Text("Logout", style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Navbar(
              selectedIndex: 4,
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

  Widget _infoCard(String label, String value, {IconData? leadingIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, size: 20),
              const SizedBox(width: 8),
            ],
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}