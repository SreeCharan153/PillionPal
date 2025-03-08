import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/onbording2.dart';
import 'package:pillionpal/Screens/welcomescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Skip Button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, right: 20),
              child: InkWell(
                onTap: () {
                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
          ),

          // Onboarding Image
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/images/welcome_1.png', // Ensure this image exists in pubspec.yaml
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Title
          Text(
            "Anywhere you are",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),

          // Subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Text(
              "Book motorcycle rides easily with PillionPal and reach your destination hassle-free.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),

          // Circular Progress Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OnboardingScreen2()),
              );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular Progress Indicator
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      value: 0.25, // Progress value (25%)
                      strokeWidth: 6,
                      backgroundColor: Colors.green[100],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(8, 183, 130, 1),
                      ),
                    ),
                  ),

                  // Circular Button with Arrow Icon
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(8, 183, 131, 1),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
