// ignore_for_file: file_names, use_build_context_synchronously, duplicate_ignore
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pillionpal/Screens/RoleSelectionPage.dart';
import 'package:pillionpal/Screens/SignUpScreen.dart';
import '../widgets/InputFields.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/CustomButtons.dart';
import '../api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false; // 🔹 Password visibility toggle
  bool isLoading = false; // 🔹 Loading indicator

  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth
  final ApiService apiService = ApiService(); // API Service for FastAPI

  // 🔹 Show SnackBar
  void _showSnackbar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  // 🔹 Sign In with FastAPI backend
  Future<void> _signIn() async {
    String username = emailController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showSnackbar("All fields are required", Colors.red);
      return;
    }

    setState(() => isLoading = true);

    try {
      bool success = await apiService.login(username, password);
      setState(() => isLoading = false);

      if (success) {
        _showSnackbar("Login successful", Colors.green);
        Get.offAll(() => const RoleSelectionPage()); // Navigate to RoleSelectionPage
      } else {
        _showSnackbar("Invalid username or password", Colors.red);
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showSnackbar("Login failed: ${e.toString()}", Colors.red);
    }
  }

  // 🔹 Google Sign-In
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.offAll(() => const RoleSelectionPage());
    } catch (e) {
      _showSnackbar("Google Sign-In failed", Colors.red);
    }
  }

  // 🔹 Forgot Password
  Future<void> _sendPasswordReset() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      _showSnackbar("Enter your email to reset password", Colors.red);
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showSnackbar("Password reset link sent to your email", Colors.green);
    } catch (e) {
      _showSnackbar("Failed to send reset email", Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 137, 85, 1),
                ),
              ),
              const SizedBox(height: 30),

              // Email Input
              InputFields.buildTextField(
                hint: "Enter your email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                context: context,
              ),
              const SizedBox(height: 16),

              // Password Input
              InputFields.buildTextField(
                hint: "Enter your password",
                controller: passwordController,
                context: context,
                isPassword: !isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _sendPasswordReset,
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color.fromRGBO(0, 137, 85, 1)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Sign In Button
              isLoading
                  ? const CircularProgressIndicator()
                  : PrimaryButton(text: "Sign In", onPressed: _signIn),
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

              // Google Sign-In Button
              CustomButtons.buildOutlinedButton(
                text: "Sign in with Google",
                icon: FontAwesomeIcons.google,
                onPressed: _signInWithGoogle,
              ),
              const SizedBox(height: 10),

              // Apple Sign-In Button (Placeholder)
              CustomButtons.buildOutlinedButton(
                text: "Sign in with Apple",
                icon: Icons.apple,
                onPressed: () {
                  _showSnackbar("Apple Sign-In Coming Soon!", Colors.orange);
                },
              ),
              const SizedBox(height: 20),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () => Get.to(() => const SignupPage()),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Color.fromRGBO(0, 137, 85, 1)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
