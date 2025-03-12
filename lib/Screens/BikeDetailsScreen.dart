import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../widgets/InputFields.dart'; // Import the utility class

class BikeDetailsScreen extends StatefulWidget {
  const BikeDetailsScreen({super.key});

  @override
  _BikeDetailsScreenState createState() => _BikeDetailsScreenState();
}

class _BikeDetailsScreenState extends State<BikeDetailsScreen> {
  final TextEditingController bikeNameController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  File? _bikeImage;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _bikeImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Bike Details", style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter your Bike Details",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),

            // Bike Name Input Field
            InputFields.buildTextField(
              hint: "Bike Name",
              controller: bikeNameController,
            ),
            SizedBox(height: 16),

            // Model Input Field
            InputFields.buildTextField(
              hint: "Model",
              controller: modelController,
            ),
            SizedBox(height: 16),

            // Upload Bike Image Button
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _bikeImage == null ? "Upload Bike Image" : "Image Selected",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _pickImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 137, 85, 1), // Green color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text("Upload", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),

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
                  child: Image.file(_bikeImage!, fit: BoxFit.cover),
                ),
              ),
            SizedBox(height: 16),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 137, 85, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
