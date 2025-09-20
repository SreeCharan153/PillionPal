import 'package:flutter/material.dart';
import 'package:pillionpal/Screens/Home.dart';
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
  final TextEditingController mileageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                  validator: (value) => value!.isEmpty ? "Please enter bike name" : null,
                ),
                const SizedBox(height: 16),

                // Model Input Field
                InputFields.buildTextField(
                  context: context,
                  hint: "Model",
                  controller: modelController,
                  validator: (value) => value!.isEmpty ? "Please enter model name" : null,
                ),
                const SizedBox(height: 16),

                // Mileage Input Field
                InputFields.buildTextField(
                  context: context,
                  hint: "Mileage (km/l)",
                  keyboardType: TextInputType.number,
                  controller: mileageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter mileage";
                    }
                    final mileage = double.tryParse(value);
                    if (mileage == null || mileage <= 0) {
                      return "Please enter a valid positive number";
                    }
                    return null;
                  },
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
