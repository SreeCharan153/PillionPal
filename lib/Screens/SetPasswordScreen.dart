// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../widgets/PrimaryButton.dart';
import '../widgets/InputFields.dart'; // ✅ Import InputFields utility

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // ✅ Form validation key

  bool _isPasswordValid(String password) {
    return password.length >= 6 &&
        RegExp(r'[A-Z]').hasMatch(password) && // ✅ At least 1 uppercase letter
        RegExp(r'[0-9]').hasMatch(password);  // ✅ At least 1 digit
  }

  void _validateAndSubmit() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password set successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      // 🚀 Proceed with password submission logic (e.g., backend API call)
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Password"),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 150), // 🔥 Increased spacing for better placement

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // 🔥 Password Field using InputFields Utility
                  InputFields.buildTextField(
                    hint: "Enter New Password",
                    controller: _passwordController,
                    isPassword: true,
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Must be 6+ characters, 1 uppercase & 1 digit",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    ),
                  ),

                  const SizedBox(height: 20), // 🔥 Slightly increased space

                  // 🔥 Confirm Password Field using InputFields Utility
                  InputFields.buildTextField(
                    hint: "Confirm Password",
                    controller: _confirmPasswordController,
                    isPassword: true,
                  ),

                  const SizedBox(height: 40), // 🔥 More space before button

                  // 🔥 Submit Button
                  PrimaryButton(
                    text: "Set Password",
                    onPressed: () {
                      if (!_isPasswordValid(_passwordController.text)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password must be 6+ characters, contain 1 uppercase & 1 digit."),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      if (_passwordController.text != _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Passwords do not match!"),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }
                      _validateAndSubmit();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
