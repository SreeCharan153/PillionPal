import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/InputFields.dart';
import '../widgets/PrimaryButton.dart';
import '../api_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  late ApiService apiService;
  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _initApiService();
  }

  Future<void> _initApiService() async {
    apiService = await ApiService.getInstance();
  }

  void _showMessage(String msg, bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? const Color.fromRGBO(0, 137, 85, 1) : Colors.red,
      ),
    );
  }

  Future<void> validatePasswords() async {
    String oldPass = oldPasswordController.text.trim();
    String newPass = newPasswordController.text.trim();
    String confirmPass = confirmPasswordController.text.trim();

    // Basic validation
    if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      _showMessage("All fields are required", false);
      return;
    }
    if (newPass != confirmPass) {
      _showMessage("New password and Confirm password do not match", false);
      return;
    }
    if (newPass.length < 6) {
      _showMessage("Password must be at least 6 characters", false);
      return;
    }

    setState(() => isLoading = true);

    final result = await apiService.changePassword(oldPass, newPass, confirmPass);

    setState(() => isLoading = false);

    bool success = result["state"] ?? false;
    String message = result["message"] ?? "Something went wrong";

    _showMessage(message, success);

    if (success) {
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      Get.back(); // Navigate back after success
    }
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
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
                  isOldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => isOldPasswordVisible = !isOldPasswordVisible),
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
                  isNewPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => isNewPasswordVisible = !isNewPasswordVisible),
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
                  isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () => setState(() => isConfirmPasswordVisible = !isConfirmPasswordVisible),
              ),
            ),
            const SizedBox(height: 30),
            isLoading
                ? const CircularProgressIndicator()
                : PrimaryButton(
                    text: "Change Password",
                    onPressed: validatePasswords,
                  ),
          ],
        ),
      ),
    );
  }
}
