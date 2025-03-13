import 'package:flutter/material.dart';
//import '../Screens/HistoryScreen.dart';
//import '../Screens/ComplainScreen.dart';
//import '../Screens/ReferralScreen.dart';
//import '../Screens/AboutUsScreen.dart';
//import '../Screens/SettingsScreen.dart';
//import '../Screens/HelpScreen.dart';
//import '../Screens/LoginScreen.dart';

class MenuDrawer extends StatelessWidget {
  final AnimationController animationController;

  const MenuDrawer({Key? key, required this.animationController})
      : super(key: key);

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

                  // Back Button
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

                  // Profile Section
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
                        Text("Nate Samson", style: theme.textTheme.titleLarge),
                        Text("nate@email.com", style: theme.textTheme.bodyMedium),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Menu Items with Navigation
                  //_menuItem(context, Icons.article, "History", HistoryScreen()),
                  //_menuItem(context, Icons.error_outline, "Complain", ComplainScreen()),
                  //_menuItem(context, Icons.people_outline, "Referral", ReferralScreen()),
                  //_menuItem(context, Icons.info_outline, "About Us", AboutUsScreen()),
                  //_menuItem(context, Icons.settings_outlined, "Settings", SettingsScreen()),
                  //_menuItem(context, Icons.help_outline, "Help and Support", HelpScreen()),
                  //_menuItem(context, Icons.logout, "Logout", LoginScreen(), isLogout: true),
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
          // Handle logout logic (e.g., clearing session, navigating to login)
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => screen),
            (route) => false, // Clears all previous routes
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
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
