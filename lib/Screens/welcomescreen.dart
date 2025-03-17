import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/SignUpScreen.dart';
import 'package:pillionpal/Screens/login_screen.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/SecondaryButton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap the content in SingleChildScrollView to prevent overflow on smaller screens
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      "PillionPal",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),

                    // Welcome Text
                    Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 5),

                    // Subtitle
                    Text(
                      "Have a better sharing experience",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 30),

                    // Primary Button - Create Account
                    PrimaryButton(
                      text: "Create an account",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignupPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 15),

                    // Secondary Button - Log In
                    SecondaryButton(
                      text: "Log In",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
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
