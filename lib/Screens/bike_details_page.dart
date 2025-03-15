import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:pillionpal/Screens/RideTracking.dart';
import 'package:pillionpal/widgets/PrimaryButton.dart';

class BikeDetailsPage extends StatelessWidget {
  final String bikeName;
  final String imageUrl;
  final String maxPower;
  final String fair;
  final String maxSpeed;
  final String acceleration;
  final String riderName;
  final String gender;
  final String bikeNo;
  final String licenceNo;

  const BikeDetailsPage({
    super.key,
    required this.bikeName,
    required this.imageUrl,
    required this.maxPower,
    required this.fair,
    required this.maxSpeed,
    required this.acceleration,
    required this.riderName,
    required this.gender,
    required this.bikeNo,
    required this.licenceNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(bikeName),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(imageUrl, height: 400),
              ),
              const SizedBox(height: 20),

              // Specifications
              Text("Specifications", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _specificationBox("Max. power", maxPower),
                  _specificationBox("Fair", fair),
                  _specificationBox("Max. speed", maxSpeed),
                  _specificationBox("0-60 mph", acceleration),
                ],
              ),
              const SizedBox(height: 20),

              // Rider & Bike Details
              Text("Rider & Bike Details", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              _infoRow("Name", riderName),
              _infoRow("Gender", gender),
              _infoRow("Bike No", bikeNo),
              _infoRow("Licence No", licenceNo),
              const SizedBox(height: 20),

              // "Ride Now" Button using PrimaryButton
              Center(
                child: PrimaryButton(
                  text: "Ride Now",
                  onPressed: () {
                    Get.to(const RideTrackingScreen());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for displaying bike specifications
  Widget _specificationBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  // Widget for displaying rider and bike details
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
