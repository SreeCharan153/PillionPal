// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/RiderRegistration.dart';
import 'package:pillionpal/Screens/Home.dart';
import '../widgets/SecondaryButton.dart';
import '../widgets/PrimaryButton.dart';
import '../api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});

  @override
  State<RoleSelectionPage> createState() => _RoleSelectionPageState();
}

class _RoleSelectionPageState extends State<RoleSelectionPage> {
  ApiService? apiService;
  bool _loading = true;
  String? _role; // store locally loaded role

  @override
  void initState() {
    super.initState();
    _initApiService();
  }

  // Initialize ApiService + load stored role
  Future<void> _initApiService() async {
    apiService = await ApiService.getInstance();

    final prefs = await SharedPreferences.getInstance();
    final storedRole = prefs.getString('role');

    if (!mounted) return;

    setState(() {
      _loading = false;
      _role = storedRole;
    });

    // print('Token loaded: ${apiService!.token}');
    // print('Role loaded: $_role');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      // Show loading indicator while initializing
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
                'assets/images/selection.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 30),

              PrimaryButton(
                text: "Continue As Rider",
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  if (_role == 'both') {
                    // If role is both → skip registration
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(isBikeMode: true),
                      ),
                    );
                  } else {
                    // Otherwise set role to rider and go to registration
                    await prefs.setString('role', 'rider');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RiderRegistration(),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 15),

              SecondaryButton(
                text: "Continue As Pillion",
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  if (_role == 'both') {
                    // If role is both → skip to home directly
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(isBikeMode: false),
                      ),
                    );
                  } else {
                    await prefs.setString('role', 'pillion');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(isBikeMode: false),
                      ),
                    );
                  }
                },
                width: double.infinity,
                borderColor: const Color(0xFF087B46),
                textColor: const Color(0xFF087B46),
                borderRadius: 8.0,
              ),

              const SizedBox(height: 20),

              if (_role != null)
                Text(
                  "Previously selected role: $_role",
                  style: const TextStyle(color: Colors.grey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
