import 'package:flutter/material.dart';
import '../screens/Home.dart';
import '../screens/HistoryPage.dart';
import '../screens/ComplainScreen.dart';
//import '../screens/ReferralScreen.dart';
import '../screens/AboutUs.dart';
import '../screens/Settings.dart';
//import '../screens/HelpScreen.dart';
//import '../screens/LoginScreen.dart';

class MenuDrawer extends StatelessWidget {
  final AnimationController animationController;
  final bool isBikeMode;

  const MenuDrawer({super.key, required this.animationController, required this.isBikeMode});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(-300 * (1 - animationController.value), 0),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            child: Container(
              width: 300,
              height: double.infinity,
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Close Menu Button
                  GestureDetector(
                    onTap: () => animationController.reverse(),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back, color: theme.textTheme.bodyMedium?.color),
                        const SizedBox(width: 10),
                        Text("Back", style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Profile Section (Dynamic Placeholder for Future Integration)
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: isDarkMode
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                          backgroundImage: const AssetImage('assets/images/profile.png'),
                        ),
                        const SizedBox(height: 10),
                        Text("User Name", style: theme.textTheme.titleLarge), // Replace with dynamic name
                        Text("user@email.com", style: theme.textTheme.bodyMedium), // Replace with dynamic email
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Menu Items
                  _menuItem(context, Icons.home, "Home", HomeScreen(isBikeMode: isBikeMode)),
                  const Divider(),
                  _menuItem(context, Icons.article, "History", const HistoryPage()),
                  const Divider(),
                  _menuItem(context, Icons.error_outline, "Complain", const ComplainScreen()),
                  const Divider(),
                  //_menuItem(context, Icons.people_outline, "Referral", const ReferralScreen()),
                  //const Divider(),
                  _menuItem(context, Icons.info_outline, "About Us", const AboutUsScreen()),
                  const Divider(),
                  _menuItem(context, Icons.settings_outlined, "Settings", const SettingsScreen()),
                  const Divider(),
                  //_menuItem(context, Icons.help_outline, "Help & Support", const HelpScreen()),
                  //const Divider(), // Adds a separator before logout
                  //_menuItem(context, Icons.logout, "Logout", const LoginScreen(), isLogout: true),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, Widget screen, {bool isLogout = false}) {
    return InkWell(
      onTap: () {
        if (isLogout) {
          // Handle logout logic (Add authentication clearing if needed)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => screen),
            (route) => false, // Clears all previous routes
          );
        } else {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => screen,
              transitionsBuilder: (_, anim, __, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                );
              },
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).textTheme.bodyMedium?.color, size: 22),
            const SizedBox(width: 15),
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
