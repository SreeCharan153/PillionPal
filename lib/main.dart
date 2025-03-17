import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import 'package:pillionpal/Screens/maps.dart';
import 'package:pillionpal/Screens/onbording2.dart';
import 'package:pillionpal/Screens/welcomescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        dividerColor: Colors.transparent, 
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white, // Light mode fill color
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.black, // Dark mode fill color
        ),
      ),
      themeMode: ThemeMode.system,
      home: map_box(),
      //home: const OnboardingScreen(),
    );
  }
} 

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.grey[800];
    final iconColor =
        isDarkMode ? Colors.white : Colors.black; // Dynamic icon color

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () {
                    _navigateToScreen(context, const WelcomeScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontSize: 16,
                        color: iconColor,
                      ), // Dynamic color
                    ),
                  ),
                ),
              ),

              // Onboarding Image
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/welcome_1.png',
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
                  color: textColor,
                ),
              ),

              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Book motorcycle rides easily with PillionPal and reach your destination hassle-free.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),

              // Circular Progress Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: GestureDetector(
                  onTap: () {
                    _navigateToScreen(context, const OnboardingScreen2());
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Circular Progress Indicator
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator(
                          value: 0.25,
                          strokeWidth: 6,
                          backgroundColor:
                              isDarkMode ? Colors.grey[800] : Colors.green[100],
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
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward,
                            size: 24,
                            color: Colors.white, // Arrow should always be white
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
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
