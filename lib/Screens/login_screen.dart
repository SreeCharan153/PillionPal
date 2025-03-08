// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pillionpal/Screens/SignUpScreen.dart';
import '../widgets/InputFields.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/CustomButtons.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo or Title
            const Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(0, 137, 85, 1),
              ),
            ),
            const SizedBox(height: 30),

            // Email Input Field
            InputFields.buildTextField(
              hint: "Enter your email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),

            // Password Input Field
            InputFields.buildTextField(
              hint: "Enter your password",
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 10),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // TODO: Implement Forgot Password Logic
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Color.fromRGBO(0, 137, 85, 1)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Sign In Button
            PrimaryButton(
              text: "Sign In",
              onPressed: () {
                // TODO: Implement Sign In Logic
              },
            ),
            const SizedBox(height: 20),

            // OR Divider
            const Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("OR"),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 20),

            // Google Sign-in Button
            CustomButtons.buildOutlinedButton(
              text: "Sign in with Gmail",
              icon: FontAwesomeIcons.google,
              onPressed: () {
                // TODO: Implement Google Sign-In
              },
            ),
            const SizedBox(height: 10),

            // Apple Sign-in Button
            CustomButtons.buildOutlinedButton(
              text: "Sign in with Apple",
              icon: Icons.apple,
              onPressed: () {
                // TODO: Implement Apple Sign-In
              },
            ),
            const SizedBox(height: 20),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Color.fromRGBO(0, 137, 85, 1)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
