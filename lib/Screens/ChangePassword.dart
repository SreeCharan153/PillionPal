import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/InputFields.dart'; // Update path as needed
import '../widgets/PrimaryButton.dart'; // Update path as needed

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void validatePasswords() {
    String oldPass = oldPasswordController.text;
    String newPass = newPasswordController.text;
    String confirmPass = confirmPasswordController.text;

    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All fields are required"),
          backgroundColor: Color.fromRGBO(0, 137, 85, 1),
        ),
      );
      return;
    }

    if (oldPass == newPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Old and New Passwords must not be the same"),
          backgroundColor: Color.fromRGBO(0, 137, 85, 1),
        ),
      );
      return;
    }

    if (newPass != confirmPass) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New and Confirm Password must match"),
          backgroundColor: Color.fromRGBO(0, 137, 85, 1),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password Changed Successfully"),
        backgroundColor: Color.fromRGBO(0, 137, 85, 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InputFields.buildTextField(
              hint: "Enter your Old Password",
              controller: oldPasswordController,
              context: context,
              isPassword: !isOldPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  isOldPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isOldPasswordVisible = !isOldPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            InputFields.buildTextField(
              hint: "Enter your New Password",
              controller: newPasswordController,
              context: context,
              isPassword: !isNewPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  isNewPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isNewPasswordVisible = !isNewPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            InputFields.buildTextField(
              hint: "Confirm Password",
              controller: confirmPasswordController,
              context: context,
              isPassword: !isConfirmPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isConfirmPasswordVisible = !isConfirmPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              text: "Change Password",
              onPressed: validatePasswords,
            ),
          ],
        ),
      ),
    );
  }
}
