import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/SignUpScreen.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/SecondaryButton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the content in SingleChildScrollView to prevent overflow on smaller screens
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Constrain the content to at least fill the screen's height
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Illustration Image
                    Image.asset(
                      'assets/images/welcome_4.png',
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 30),

                    // App Title
                    Text(
                      "College Ride",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Welcome Text
                    const Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),

                    // Subtitle
                    const Text(
                      "Have a better sharing experience",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 30),

                    // Primary Button - Create Account
                    PrimaryButton(
                      text: "Create an account",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),

                    // Secondary Button - Log In
                    SecondaryButton(
                      text: "Log In",
                      onPressed: () {
                        // ignore: avoid_print
                        print("Log In clicked!");
                      },
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
