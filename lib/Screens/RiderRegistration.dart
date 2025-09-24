import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pillionpal/Screens/BikeDetailsScreen.dart';
import '../widgets/InputFields.dart'; // InputFields utility
import '../widgets/PrimaryButton.dart'; // PrimaryButton widget
import "../api_service.dart";

class RiderRegistration extends StatefulWidget {
  const RiderRegistration({super.key});

  @override
  _RiderRegistration createState() => _RiderRegistration();
}

class _RiderRegistration extends State<RiderRegistration> {
  final TextEditingController aadharController = TextEditingController();
  final TextEditingController licenseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late ApiService apiService;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initApiService();
  }

  void _initApiService() async {
    apiService = await ApiService.getInstance();
  }

void _submitDetails() async {
  if (!_formKey.currentState!.validate() || _isLoading) return;

  setState(() {
    _isLoading = true;
  });

  final aadhardata = aadharController.text.trim();
  final licensedata = licenseController.text.trim();

  final data = await apiService.registerRider(
    aadhar_number: aadhardata,
    license_number: licensedata,
  );

  setState(() {
    _isLoading = false;
  });

  if (data["error"] == null) {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("auth_token")) {
      await prefs.remove("auth_token");
    } 

    await prefs.setString("auth_token", data["token"]);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Rider registered successfully!"),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const BikeDetailsScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(data["error"]),
        backgroundColor: Colors.red,
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
        title: const Text("Rider Details", style: TextStyle(color: Colors.black)),
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
                  "Enter your Details",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 20),

                // Aadhar Input Field
                InputFields.buildTextField(
                  context: context,
                  hint: "Aadhar Number",
                  controller: aadharController,
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? "Please enter Aadhar Number" : null,
                ),
                const SizedBox(height: 16),

                // Driving License Input
                InputFields.buildTextField(
                  context: context,
                  hint: "Your Driving License Number Plate",
                  controller: licenseController,
                  validator: (value) => value!.isEmpty ? "Please enter DL number" : null,
                ),
                const SizedBox(height: 16),

                // Submit Button using PrimaryButton
                Center(
                  child: PrimaryButton(
                    text: _isLoading ? "Submitting..." : "Submit",
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
