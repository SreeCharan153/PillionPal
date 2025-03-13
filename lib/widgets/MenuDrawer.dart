import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.9), // Semi-transparent effect
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Nate Samson",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "nate@email.com",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(color: Colors.white30, thickness: 1),

            // Menu Items
            _buildMenuItem(Icons.history, "History"),
            _buildMenuItem(Icons.warning, "Complain"),
            _buildMenuItem(Icons.people, "Referral"),
            _buildMenuItem(Icons.info, "About Us"),
            _buildMenuItem(Icons.settings, "Settings"),
            _buildMenuItem(Icons.help, "Help and Support"),
            _buildMenuItem(Icons.logout, "Logout"),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: () {},
    );
  }
}
