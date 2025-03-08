import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/SecondaryButton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          // Centering the content properly
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ), // Balanced padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Ensures everything is centered
              children: [
                const Spacer(),

                // Illustration Image
                Image.asset(
                  'assets/images/welcome_4.png',
                  width:
                      MediaQuery.of(context).size.width *
                      0.85, // More balanced width
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
                const Spacer(),

                // Buttons
                PrimaryButton(
                  text: "Create an account",
                  onPressed: () {
                    print("Create an account clicked!");
                  },
                ),
                const SizedBox(height: 15),

                SecondaryButton(
                  text: "Log In",
                  onPressed: () {
                    print("Log In clicked!");
                  },
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
