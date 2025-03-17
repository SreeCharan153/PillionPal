import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  void _confirmDelete(BuildContext context) {
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
              onPressed: () {
                Get.back(); // Close dialog
                _deleteAccount(); // Call delete function
              },
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteAccount() {
    // Handle account deletion logic here (Firebase, API call, etc.)
    Get.snackbar(
      "Deleted",
      "Your account has been deleted.",
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => _confirmDelete(context),
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
