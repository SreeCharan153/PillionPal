import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/Screens/RoleSelectionPage.dart';
import '../widgets/InputFields.dart'; // Import InputFields utility
import '../widgets/PrimaryButton.dart'; // Import PrimaryButton widget
import '../widgets/SecondaryButton.dart'; // Import SecondaryButton widget
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({super.key});

  @override
  _CompleteProfileState createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  String? selectedCity;
  String? selectedDistrict;
  File? _image;

  final List<String> cities = ["City 1", "City 2", "City 3"];
  final List<String> districts = ["District 1", "District 2", "District 3"];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _validateFields() {
    if (nameController.text.trim().isEmpty ||
        streetController.text.trim().isEmpty ||
        selectedCity == null ||
        selectedDistrict == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields before proceeding."),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Get.to(const RoleSelectionPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Fix for black screen
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fix layout issue
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Section
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? const Icon(Icons.person, size: 50, color: Colors.white)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: const Color.fromRGBO(0, 137, 85, 1),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _pickImage,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Input Fields
            InputFields.buildTextField(
              context: context,
              hint: "Full Name",
              controller: nameController,
            ),
            const SizedBox(height: 12),
            InputFields.buildTextField(
              context: context,
              hint: "Street",
              controller: streetController,
            ),
            const SizedBox(height: 12),

            // Dropdown Fields
            InputFields.buildDropdownField(
              context: context,
              hint: "City",
              items: cities,
              value: selectedCity ?? cities[0], // Fix for null value
              onChanged: (value) => setState(() => selectedCity = value),
            ),
            const SizedBox(height: 12),
            InputFields.buildDropdownField(
              context: context,
              hint: "District",
              items: districts,
              value: selectedDistrict ?? districts[0], // Fix for null value
              onChanged: (value) => setState(() => selectedDistrict = value),
            ),

            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: "Cancel",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PrimaryButton(
                    text: "Save",
                    onPressed: _validateFields, // Calls validation before navigation
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
