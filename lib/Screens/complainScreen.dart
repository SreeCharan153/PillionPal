import 'package:flutter/material.dart';
import '../widgets/InputFields.dart';
import '../widgets/PrimaryButton.dart';

class ComplainScreen extends StatefulWidget {
  const ComplainScreen({super.key});

  @override
  State<ComplainScreen> createState() => _ComplainScreenState();
}

class _ComplainScreenState extends State<ComplainScreen> {
  String selectedReason = "Vehicle not clean";
  final TextEditingController _complainController = TextEditingController();

  final List<String> complainReasons = [
    "Vehicle not clean",
    "Rider misbehavior",
    "Overcharging",
    "Late arrival",
    "Other"
  ];

  void _submitComplain() {
    if (_complainController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complain must be at least 10 characters"),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Complain submitted successfully"),
          backgroundColor: Colors.green,
        ),
      );
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
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Complain", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Field
            InputFields.buildDropdownField(
              context: context,
              hint: "Select Reason",
              items: complainReasons,
              value: selectedReason,
              onChanged: (value) {
                setState(() {
                  selectedReason = value!;
                });
              },
            ),
            const SizedBox(height: 16),

            // Complain Text Field
            InputFields.buildTextField(
              context: context,
              hint: "Write your complain here (minimum 10 characters)",
              controller: _complainController,
            ),
            const SizedBox(height: 20),

            // Submit Button
            PrimaryButton(
              text: "Submit",
              onPressed: _submitComplain,
            ),
          ],
        ),
      ),
    );
  }
}
