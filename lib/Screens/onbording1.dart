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
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Automatically switch theme
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.grey[800];
    final bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Skip Button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      _navigateToScreen(context, const WelcomeScreen());
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(fontSize: 16, color: textColor),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Onboarding Image
              Image.asset(
                'assets/images/welcome_1.png', // Ensure image exists in pubspec.yaml
                width: 300,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 20),

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
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  "Book motorcycle rides easily with PillionPal and reach your destination hassle-free.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ),

              const Spacer(),

              // Circular Progress Button
              GestureDetector(
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
                        value: 0.25, // 25% progress
                        strokeWidth: 6,
                        backgroundColor:
                            isDarkMode ? Colors.grey[700] : Colors.green[100],
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
                          color: Colors.white, // Always white
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
