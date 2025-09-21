import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api_service.dart';
import 'login_screen.dart';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  _DeleteAccountScreenState createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {
  late ApiService apiService;
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    _initApiService();
  }

  Future<void> _initApiService() async {
    apiService = await ApiService.getInstance();
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Deletion"),
          content: const Text(
            "Are you sure you want to delete your account? This action is irreversible.",
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                Get.back(); // Close dialog
                await _deleteAccount(); // Call delete function
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    setState(() => isDeleting = true);
    final message = await apiService.deleteAccount(); // Returns String
    setState(() => isDeleting = false);

    Get.snackbar(
      "Account Status",
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    if (message.contains("successfully")) {
      // Navigate back to login page
      Get.offAll(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Delete Account",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Are you sure you want to delete your account? Please read how account deletion will affect.",
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Text(
              "Deleting your account removes personal information from our database. "
              "Your email becomes permanently reserved and cannot be reused to register a new account.",
              style: theme.textTheme.bodyMedium,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: isDeleting
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _confirmDelete,
                      child: const Text(
                        "Delete",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
