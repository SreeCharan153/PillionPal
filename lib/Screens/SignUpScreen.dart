// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pillionpal/Screens/login_screen.dart';
import '../widgets/InputFields.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/CustomButtons.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool agreeToTerms = false;
  bool isPasswordVisible = false; // 🔥 New state for password visibility

  void _signUp() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    // Validate Fields
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required"),
          backgroundColor: Color.fromRGBO(0, 137, 85, 1),
        ),
      );
      return;
    }

    // Validate Terms & Conditions
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You must agree to the Terms & Conditions"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Implement Sign Up Logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),

              // Title
              const Text(
                "Create Your Account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(0, 137, 85, 1),
                ),
              ),
              const SizedBox(height: 30),

              // Full Name
              InputFields.buildTextField(
                hint: "Full Name",
                controller: nameController,
              ),
              const SizedBox(height: 16),

              // Email
              InputFields.buildTextField(
                hint: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Phone Number
              InputFields.buildPhoneNumberField(controller: phoneController),
              const SizedBox(height: 16),

              // Password with View Button 🔥
              TextField(
                controller: passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Terms & Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    value: agreeToTerms,
                    activeColor: const Color.fromRGBO(0, 137, 85, 1),
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      "I agree to the Terms & Conditions",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Sign Up Button
              PrimaryButton(text: "Sign Up", onPressed: _signUp),
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

              // Google Sign-Up Button
              CustomButtons.buildOutlinedButton(
                text: "Sign up with Gmail",
                icon: FontAwesomeIcons.google,
                onPressed: () {
                  // TODO: Implement Google Sign-Up
                },
              ),
              const SizedBox(height: 10),

              // Apple Sign-Up Button
              CustomButtons.buildOutlinedButton(
                text: "Sign up with Apple",
                icon: Icons.apple,
                onPressed: () {
                  // TODO: Implement Apple Sign-Up
                },
              ),
              const SizedBox(height: 20),

              // Already have an account? Sign In
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      "Sign In",
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
