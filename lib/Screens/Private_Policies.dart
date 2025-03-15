import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: Center(
          child: Text(
            "Privacy Policy",
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
            
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Privacy Policy for PillionPal",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "At PillionPal, accessible from pillionpal.com, one of our main priorities is the privacy of our users. "
                "This Privacy Policy document contains types of information that are collected and recorded by PillionPal and how we use it.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "If you have additional questions or require more information about our Privacy Policy, do not hesitate to contact us.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              Text(
                "This Privacy Policy applies only to our online activities and is valid for users of our app regarding the information they share and/or collect in PillionPal. "
                "This policy is not applicable to any information collected offline or via channels other than this app.",
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
