import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Us",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Text(
            "Welcome to PillionPal – your go-to motorcycle ride-sharing platform! 🚀\n\n"
            "At PillionPal, we aim to revolutionize urban commuting by making bike rides safer, affordable, and accessible for everyone. "
            "Whether you're a daily commuter looking for a budget-friendly ride or a rider wanting to share your journey, we've got you covered!\n\n"
            "Our platform connects riders and passengers seamlessly, ensuring a smooth and hassle-free experience. "
            "We focus on providing **reliable, cost-effective, and eco-friendly** travel solutions while prioritizing safety and convenience.\n\n"
            "🔹 **Why Choose PillionPal?**\n"
            "✔️ Affordable & Fast Commutes\n"
            "✔️ Verified Riders & Secure Payments\n"
            "✔️ Easy-to-Use App with Live Tracking\n"
            "✔️ Contribute to a Greener Future\n\n"
            "Join PillionPal today and experience the future of urban mobility. Your ride, your way! 🏍️✨",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
