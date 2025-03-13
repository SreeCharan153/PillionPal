import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillionpal/Screens/Home.dart';
import 'dart:io';

import '../widgets/InputFields.dart'; // Import InputFields utility
import '../widgets/PrimaryButton.dart'; // Import PrimaryButton widget

class BikeDetailsScreen extends StatefulWidget {
  const BikeDetailsScreen({super.key});

  @override
  _BikeDetailsScreenState createState() => _BikeDetailsScreenState();
}

class _BikeDetailsScreenState extends State<BikeDetailsScreen> {
  final TextEditingController bikeNameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  File? _bikeImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _bikeImage = File(pickedFile.path);
      });
    }
  }

  void _submitDetails() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(isBikeMode: true)),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bike details submitted successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Bike Details", style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your Bike Details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Bike Name Input Field
                InputFields.buildTextField(
                  context: context,
                  hint: "Bike Name",
                  controller: bikeNameController,
                ),
                const SizedBox(height: 16),

                // Model Input Field
                InputFields.buildTextField(
                  context: context,
                  hint: "Model",
                  controller: modelController,
                ),
                const SizedBox(height: 16),

                // Upload Bike Image Button
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _bikeImage == null ? "Upload Bike Image" : "Image Selected",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Upload Button using PrimaryButton
                    PrimaryButton(
                      text: "Upload",
                      onPressed: _pickImage,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Image Preview
                if (_bikeImage != null)
                  Center(
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(_bikeImage!, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),

                // Submit Button using PrimaryButton
                Center(
                  child: PrimaryButton(
                    text: "Submit",
                    onPressed: _submitDetails,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
