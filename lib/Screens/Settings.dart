import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/Screens/Private_Policies.dart';
import 'package:pillionpal/Screens/contactus.dart';
import '../Widgets/SettingsTile.dart';
import "ChangePassword.dart";
import 'DeleteAccount.dart'; // Ensure you have the reusable widget

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  void ChangePassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SettingsTile(
              title: "Change Password",
              onTap: () => ChangePassword(context),
            ),
            const SizedBox(height: 10),
            /*SettingsTile(
              title: "Change Language",
              onTap: () => print("Change Language Clicked"),
            ),
            const SizedBox(height: 10),*/
            SettingsTile(
              title: "Privacy Policy",
              onTap: () => Get.to(() => const PrivacyPolicyScreen()),
            ),
            const SizedBox(height: 10),
            SettingsTile(
              title: "Contact Us",
              onTap: () => Get.to(ContactUsScreen()),
            ),
            const SizedBox(height: 10),
            SettingsTile(
              title: "Delete Account",
              onTap: () => Get.to(() => DeleteAccountScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
