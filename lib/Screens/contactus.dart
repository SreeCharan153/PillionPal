import 'package:flutter/material.dart';
import '../widgets/InputFields.dart'; // Importing your InputFields class

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ContactUsScreen(),
    );
  }
}

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Controllers
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                'Contact us for Ride share',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'House# 72, Road# 21, Banani, Dhaka-1213\n'
                '(near Banani Bidyaniketon School & College, beside University of South Asia)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              const Text(
                'Call: 13301 (24/7)\nEmail: support@pathao.com',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Send Message Title
              const Text(
                'Send Message',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),

              // Name Input Field (Using InputFields class)
              InputFields.buildTextField(
                context: context,
                hint: "Name",
                controller: nameController,
              ),
              const SizedBox(height: 10),

              // Email Input Field
              InputFields.buildTextField(
                context: context,
                hint: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),

              // Phone Number Field
              InputFields.buildPhoneNumberField(
                context: context,
                controller: phoneController,
              ),
              const SizedBox(height: 10),

              // Message Input Field
              InputFields.buildTextField(
                context: context,
                hint: "Write your text",
                controller: messageController,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),

              // Send Message Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // Handle Send Message
                  },
                  child: const Text(
                    'Send Message',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
