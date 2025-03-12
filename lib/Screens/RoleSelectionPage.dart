// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/BikeDetailsScreen.dart';
import 'package:pillionpal/Screens/bike_list_page.dart';
import '../widgets/SecondaryButton.dart'; // Import SecondaryButton
import '../widgets/PrimaryButton.dart'; // Import PrimaryButton

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Choose Your Role",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Rider or Pillion",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 180),
              Image.asset(
                'assets/images/selection.png', // Replace with your image asset path
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 30),
              PrimaryButton(
                text: "Continue As Rider",
                onPressed: () {
                  // Handle Rider Selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BikeDetailsScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              SecondaryButton(
                text: "Continue As Pillion",
                onPressed: () {
                  // Handle Pillion Selection
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BikeListPage()),
                  );
                },
                width: double.infinity,
                borderColor: const Color(
                  0xFF087B46,
                ), // Match primary button color
                textColor: const Color(0xFF087B46),
                borderRadius: 8.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
